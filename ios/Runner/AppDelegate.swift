import UIKit
import Flutter
import CoreNFC
import SDK
import Foundation
import BigInt

@main
@objc class AppDelegate: FlutterAppDelegate, NFCNDEFReaderSessionDelegate {
    private var nfcSession: NFCNDEFReaderSession?
    private var result: FlutterResult?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let nfcChannel = FlutterMethodChannel(name: "com.example.skey/nfc",
                                              binaryMessenger: controller.binaryMessenger)
        nfcChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in

            guard let strongSelf = self else {return}
            if(call.method == "getPublickKey"){
                if let args = call.arguments as? [String : Any],
                   let messageHash = args["messageHash"] as? String {
                    self?.getPublicKey(result: result, messageHash: messageHash)
                }else{
                    result("error")
                    return
                }
            }else if(call.method == "pairCard"){
                if let args = call.arguments as? [String : Any],
                        let pin = args["pin"] as? String {
                        self?.pairCard(result: result, pin: pin)
                    }else{
                            result("error")
                            return
                    }

            }else if(call.method == "getCompressedKey"){
                self?.getCompressedPublicKey(result: result)

            }else if (call.method == "signHash"){
                if let args = call.arguments as? [String : Any],
                   let messageHash = args["hash"] as? String {
                    self?.signHash(result: result, messageHash: messageHash)
                }else{
                    result("error")
                    return
                }


            }else if(call.method == "sendTransaction"){
                if let args = call.arguments as? [String : Any] {
                    self?.sendTransaction(result: result, args: args)
            }else{
                result("error")
                return
            }
            }else if(call.method == "unpairCard"){
                self?.unpairCard(result: result)
            }else{
                result(FlutterMethodNotImplemented)
                return
            }
        }
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func sendTransaction(result: @escaping FlutterResult, args: [String : Any]) {
        self.result = result
        NFCHelper.getInstance().waitForCommunication() { communication in
            do {
                let manager = try BchainManager.build(communication: communication)
                try manager.connect()
                //let cvm = try manager.getUserAuthenticationRule()
//                if cvm == CardStatus.CVM_PIN_AND_BIO_REQUIRED {
//                    let pin = Settings.getPin()
//                    try manager.verifyPin(pin)
//                }
                
                // Check params
                let to = args["to"]
//                let gasPrice = BigUInt(1_000_000)
//                let gasLimit = BigUInt(6_000_000)
                let gasPrice = BigUInt(args["gasPrice"] as! Int)
                let gasLimit = BigUInt(args["gasLimit"] as! Int)
                let value = BigUInt(args["value"] as! Int) // Value unit
                let nonce = args["nonce"]
                let chainId = args["chainId"]
                let bipPath = args["bipPath"]
                var data = Data()
                if(args["data"] != nil){
                    let argsData =  args["data"] as! String
                    data = Data(hexStringToUInt8Array(hex: argsData) ?? [])
                }
                
                print("data : \(data.count)" )
                
                let transactionData = TransactionData(to: to as! String, gasPrice: gasPrice , gasLimit: gasLimit , value: value, nonce: nonce as! Int64, chainId: chainId as? Int64, data: data) // Build ether transaction
                    
                let rawTransaction = transactionData.toRaw()
                guard let rlpEncodedTrx = rawTransaction.raw // RLP encode
                else { throw SDKException(message: .CANNOT_CREATE_TRANSACTION_DATA, code: .INTERNAL_ERROR) }
                
                NFCHelper.getInstance().showMessage("Fingerprint verification")
                let transactionHash = EthereumTransaction.hashTransaction(rlpEncodedTrx) // Hash data
                let signature = try manager.signMessageHash(bipPath: bipPath as! String, messageHash: transactionHash) // Perform signature
                
                let fixedSignature = CryptoHelper.fixSignature(signature: signature)
                let signedTransaction = SignedTransaction(transaction: rawTransaction, signature: fixedSignature)
                guard let rlpEncodedSignature = signedTransaction.raw
                else { throw SDKException(message: .CANNOT_CREATE_TRANSACTION_DATA, code: .INTERNAL_ERROR) }
                
                let resultVerify = try manager.verifySignature(bipPath: bipPath as! String,
                                                         messageHash: transactionHash,
                                                         signature: signature)
                if(resultVerify == false) {
                    throw RuntimeError("Signature not valid")
                }
                
                SDKLog.logInfo("Transaction data: \(rlpEncodedSignature.toHex())" )
                // TODO: send rlpEncodedSignature to blockchain
                
                NFCHelper.getInstance().stopDetector(successMessage: "Done")
            
                result(rlpEncodedSignature.toHex())
            } catch let error {
                NFCHelper.getInstance().stopDetector(errorMessage: error.localizedDescription) // Close NFC popup with error
                result("Error")
            }
        }
    }

    private func getPublicKey(result: @escaping FlutterResult, messageHash: String ) {
        self.result = result
        //    nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        //    nfcSession?.begin()
        NFCHelper.getInstance().waitForCommunication() { communication in
            do {
                // Card detected
                // Execute in background thread to not block main thread ...
                let manager =  try BchainManager.build(communication: communication)
                try manager.connect()

                //try manager.getCardStatus()
                //try manager.unpairCard()
                NFCHelper.getInstance().showMessage("Fingerprint verification")
                //try manager.pairCard(pin: "123456")
                let publicKeyData = try manager.getPublicKey(bipPath: "m/44'/60'/0'/0/0", withChainCode: false, compressedKey: false)
                let addressEth = "0x\(CryptoHelper.publicKeyToAddress(publicKey: publicKeyData).toHex())"
                let signature = try manager.signMessageHash(bipPath: "m/44'/60'/0'/0/0", messageHash: messageHash.toHex())
                let isSignatureValid = try manager.verifySignature(bipPath: "m/44'/60'/0'/0/0", messageHash: messageHash.toHex(), signature: signature)
                let webSign = CryptoHelper.fixSignature(signature: signature)


                let results : [String: Any] = [
                    "number" : "1234",
                    "sign" : webSign.getRaw().toHex(),
                    "valid" : isSignatureValid,
                    "publicKey" : addressEth
                ]

                NFCHelper.getInstance().stopDetector(successMessage: "Done")
                result(results);
            } catch let error {
                // Card not detected - timeout
                print(error.localizedDescription)
                NFCHelper.getInstance().stopDetector(errorMessage: error.localizedDescription)
                result("error")
            }
        }

    }

    private func signHash(result: @escaping FlutterResult, messageHash: String ) {
        self.result = result
        //    nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        //    nfcSession?.begin()
        NFCHelper.getInstance().waitForCommunication() { communication in
            do {

                var manager =  try BchainManager.build(communication: communication)
                try manager.connect()

                NFCHelper.getInstance().showMessage("Fingerprint verification")

                let signature = try manager.signMessageHash(bipPath: "m/44'/529'/0'/0/0", messageHash: messageHash.toHex()

                )
                let isSignatureValid = try manager.verifySignature(bipPath: "m/44'/529'/0'/0/0", messageHash: messageHash.toHex(), signature: signature)
                let webSign = CryptoHelper.fixSignature(signature: signature)
                let results : [String: Any] = [
                    "webSign" : webSign.getRaw().toHex(),
                    "valid" : isSignatureValid,
                    "sign": signature.getRaw().toHex(),
                    "r" : signature.getR().toHex(),
                    "s" : signature.getS().toHex(),
                    "v" : signature.getV().toHex()

                ]

                NFCHelper.getInstance().stopDetector(successMessage: "Done")
                result(results);
            } catch let error {
                // Card not detected - timeout
                print(error.localizedDescription)
                NFCHelper.getInstance().stopDetector(errorMessage: error.localizedDescription)
                result("error")
            }
        }

    }

    private func pairCard(result: @escaping FlutterResult, pin : String ) {
        self.result = result
        //    nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        //    nfcSession?.begin()
        NFCHelper.getInstance().waitForCommunication() { communication in
            do {
                // Card detected
                // Execute in background thread to not block main thread ...
                var manager =  try BchainManager.build(communication: communication)
                try manager.connect()
                var pairStatus = try manager.isCardPaired()
                
                if(pairStatus){
                    //result("Already Paired")
                    let publicKeyData = try manager.getPublicKey(bipPath: "m/44'/60'/0'/0/0", withChainCode: false, compressedKey: false)
                    let addressEth = "0x\(CryptoHelper.publicKeyToAddress(publicKey: publicKeyData).toHex())"
                    let results : [String: Any] = [
                        "address" : addressEth
                    ]
                
                    NFCHelper.getInstance().stopDetector(successMessage: "Already Paired")
                    result(results)
                }else{
                    NFCHelper.getInstance().showMessage("Fingerprint verification")
                    try manager.pairCard(pin: pin)
                   
                    let publicKeyData = try manager.getPublicKey(bipPath: "m/44'/60'/0'/0/0", withChainCode: false, compressedKey: false)
                    let addressEth = "0x\(CryptoHelper.publicKeyToAddress(publicKey: publicKeyData).toHex())"
                    let results : [String: Any] = [
                        "address" : addressEth
                    ]
                  
                    NFCHelper.getInstance().stopDetector(successMessage: "Paired")
                    result(results)
                }
              
                
            } catch let error {
                // Card not detected - timeout
                print(error.localizedDescription)
                NFCHelper.getInstance().stopDetector(errorMessage: error.localizedDescription)
                result("error")
            }
        }

    }
    private func unpairCard(result: @escaping FlutterResult) {
        self.result = result
        //    nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        //    nfcSession?.begin()
        NFCHelper.getInstance().waitForCommunication() { communication in
            do {
                // Card detected
                // Execute in background thread to not block main thread ...
                var manager =  try BchainManager.build(communication: communication)
                try manager.connect()
                var pairStatus = try manager.isCardPaired()
                if(pairStatus){
                    try manager.unpairCard()
                    result("unpaired")
                }else{
                    result("Not Paired")
                }
            } catch let error {
                // Card not detected - timeout
                print(error.localizedDescription)
                NFCHelper.getInstance().stopDetector(errorMessage: error.localizedDescription)
                result("error")
            }
        }

    }
    private func getCompressedPublicKey(result: @escaping FlutterResult) {
        self.result = result
        //    nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        //    nfcSession?.begin()
        NFCHelper.getInstance().waitForCommunication() { communication in
            do {
                // Card detected
                // Execute in background thread to not block main thread ...
                var manager =  try BchainManager.build(communication: communication)
                try manager.connect()

                //try manager.getCardStatus()
                //try manager.unpairCard()
                NFCHelper.getInstance().showMessage("Fingerprint verification")
                let publicKeyData = try manager.getPublicKey(bipPath: "m/44'/60'/0'/0/0", withChainCode: false, compressedKey: true)


                NFCHelper.getInstance().stopDetector(successMessage: "Paired")
                result(publicKeyData);
            } catch let error {
                // Card not detected - timeout
                print(error.localizedDescription)
                NFCHelper.getInstance().stopDetector(errorMessage: error.localizedDescription)
                result("error")
            }
        }

    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        result?("NFC Session invalidated: \(error.localizedDescription)")
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        if let nfcMessage = messages.first {
            let payloadData = nfcMessage.records.first?.payload
            if let data = payloadData {
                result?(data.base64EncodedString())
            } else {
                result?("No NFC data found")
            }
        } else {
            result?("No NFC data found")
        }
    }

}

extension String {

    func toHex() -> Data {
        var data = Data()
        var trimmedValue = self.replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "\n", with: "") // clear white spaces and \n
        if(trimmedValue.count % 2 != 0) { // if not full hex value
            trimmedValue = "0".appending(trimmedValue) // append 0 to have a full hex value
        }

        let length = trimmedValue.count
        if length == 0 {
            return data
        }

        var index = trimmedValue.startIndex
        for _ in 0 ..< length/2 {
            let nextIndex = trimmedValue.index(index, offsetBy: 2)
            if let b = UInt8(trimmedValue[index..<nextIndex], radix: 16) {
                data.append(b)
            }

            index = nextIndex
        }

        return data
    }

    func trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func format(_ args: CVarArg...) -> String {
        return String(format:self, arguments: args)
    }

}

extension Data {

    func toHex(toUpperCase:Bool = true, separator: String = "") -> String {
        let format = toUpperCase ? "%02hhX" : "%02hhx"
        return map { String(format: format, $0) }.joined(separator: separator)
    }

}

func hexStringToUInt8Array(hex: String) -> [UInt8]? {
    // Remove any non-hex characters (optional)
    let cleanedHex = hex.replacingOccurrences(of: "[^0-9a-fA-F]", with: "", options: .regularExpression)

    // Check if the cleaned string has an even number of characters
    guard cleanedHex.count % 2 == 0 else {
        print("Hex string must have an even number of characters.")
        return nil
    }

    // Create an array of UInt8 by converting each pair of hex characters
    var byteArray: [UInt8] = []
    
    for i in stride(from: 0, to: cleanedHex.count, by: 2) {
        let startIndex = cleanedHex.index(cleanedHex.startIndex, offsetBy: i)
        let endIndex = cleanedHex.index(startIndex, offsetBy: 2)
        let hexPair = cleanedHex[startIndex..<endIndex]

        if let byte = UInt8(hexPair, radix: 16) {
            byteArray.append(byte)
        } else {
            print("Invalid hex pair: \(hexPair)")
            return nil
        }
    }
    
    return byteArray
}

