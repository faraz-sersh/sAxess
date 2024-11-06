package com.example.skey

import android.util.Log
import androidx.lifecycle.lifecycleScope
import com.example.skey.ethereum.EthereumTransaction
import com.example.skey.ethereum.EthereumTransactionData
import com.example.skey.ethereum.ValueUnit
import com.example.skey.utils.Hex
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import com.idemia.bchain.communication.nfc.NFCHelper
import com.idemia.bchain.error.SDKException
import com.idemia.bchain.sdk.data.CardStatus
import com.idemia.bchain.sdk.manager.BchainManager
import com.idemia.bchain.util.crypto.CryptoHelper
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import java.math.BigInteger
import java.util.Arrays

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.serenity.skey"
    private val transactionChannel = "com.serenity.skey/event"
    private val pairChannel = "com.serenity.skey/pair"
    private val pinChannel = "com.serenity.skey/pin"
    private val keyChannel = "com.serenity.skey/key"
    private val STREAM_CHANNEL = "com.serenity.skey/streamChannel"
    private var eventSink: EventChannel.EventSink? = null
    private var pin: String? = "123456";
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "setPin") {
                val args = call.arguments as Map<*, *>
                pin = args["pin"] as String
                Log.i("Pin", pin!!)


            }
        }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, STREAM_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    // Simulate sending results twice
                    eventSink = events;
                    lifecycleScope.launch {
                        Log.i("Listen", "True Native")
                        eventSink?.success("Waiting For Card")

                        delay(2000) // Non-blocking delay
                        eventSink?.success("Card Connected")
                        delay(1000) // Non-blocking delay
                        eventSink?.success("Fingerprint Verification")
                        delay(1000) // Non-blocking delay
                        eventSink?.success("Done")
                        eventSink?.endOfStream()
                    }
                }

                override fun onCancel(arguments: Any?) {
                    // Handle cancel events if needed
                    Log.i("Canel", "True Cancel")
//                    eventSink?.endOfStream()
                    eventSink = null
                }
            }
        )
        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            transactionChannel
        ).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    val args = arguments as? Map<*, *>
                    if (args != null) {
                        sendTransaction(args, events)
                    } else {
                        events?.success("Arguments can't be null")
                        events?.endOfStream()
                    }
                }

                override fun onCancel(arguments: Any?) {
                    NFCHelper.getInstance().stopCardDetector(activity)

                }
            }
        )

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, pairChannel).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
//                    val args = arguments as? Map<*, *>
                    if (pin != null) {
                        pairCard(events)
                    } else {
                        events?.success("Pin can't be null")
                        events?.endOfStream()
                    }
                }

                override fun onCancel(arguments: Any?) {
                    NFCHelper.getInstance().stopCardDetector(activity)

                }
            }
        )
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, pinChannel).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    val args = arguments as? Map<*, *>
                    if (args != null) {
                        changePin(args, events)
                    } else {
                        events?.success("Arguments can't be null")
                        events?.endOfStream()
                    }
                }

                override fun onCancel(arguments: Any?) {
                    NFCHelper.getInstance().stopCardDetector(activity)

                }
            }
        )
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, keyChannel).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    val args = arguments as? Map<*, *>
                    if (args != null) {
                        getPublicKey(args, events)
                    } else {
                        events?.success("Arguments can't be null")
                        events?.endOfStream()
                    }
                }

                override fun onCancel(arguments: Any?) {
                    NFCHelper.getInstance().stopCardDetector(activity)

                }
            }
        )
    }

    private fun getPublicKey(args: Map<*, *>, events: EventChannel.EventSink?) {
        NFCHelper.getInstance().waitForCommunication(activity) { communication ->
            events?.success("Connected to card")
            try {
                val manager =
                    BchainManager.build(activity, communication)
                manager.connect() // Connect to card
                events?.success("Fingerprint Verification")
                if (manager.isCardPaired) {
                    events?.success("Card Already Paired")
                    events?.endOfStream()
                    throw RuntimeException("Card Already Paired")
                }
                val bipPath = args["bipPath"].toString()
                val withChainCode = args["withChainCode"] as Boolean
                val compressedKey = args["compressedKey"] as Boolean


                val publicKeyData = manager.getPublicKey(bipPath, withChainCode, compressedKey)

                val publicKey: ByteArray
                val chainCode: ByteArray
                if (compressedKey) {
                    publicKey = Arrays.copyOfRange(publicKeyData, 0, 33)
                    if (withChainCode) {
                        chainCode = Arrays.copyOfRange(publicKeyData, 33, publicKeyData.size)
                    } else {
                        chainCode = ByteArray(0)
                    }
                } else {
                    publicKey = Arrays.copyOfRange(publicKeyData, 0, 65)
                    if (withChainCode) {
                        chainCode = Arrays.copyOfRange(publicKeyData, 65, publicKeyData.size)
                    } else {
                        chainCode = ByteArray(0)
                    }
                }

                val addressEth = "0x" + Hex.encode(CryptoHelper.publicKeyToAddress(publicKey))

                val response: Map<String, Any?> = mapOf(
                    "publicKey" to Hex.encode(publicKey),
                    "chain" to Hex.encode(chainCode),
                    "address" to addressEth,
                )

                events?.success("Done")
                events?.success(response)
                events?.endOfStream()


            } catch (e: SDKException) {
                e.printStackTrace()
                events?.error(e.message.toString(), "Unknown Error", e)
                events?.endOfStream()

            }
        }
    }

    private fun changePin(args: Map<*, *>, events: EventChannel.EventSink?) {
        NFCHelper.getInstance().waitForCommunication(activity) { communication ->
            events?.success("Connected to card")
            try {
                val manager =
                    BchainManager.build(activity, communication)
                manager.connect() // Connect to card
                events?.success("Fingerprint Verification")
                if (manager.isCardPaired) {
                    events?.success("Card Already Paired")
                    events?.endOfStream()
                    throw RuntimeException("Card Already Paired")
                }
                manager.verifyPin(args["oldPin"].toString())

                manager.changePin(args["newPin"].toString())

                events?.success("Pin Changed Successfully")
                events?.endOfStream()


            } catch (e: SDKException) {
                e.printStackTrace()
                events?.error(e.message.toString(), "Unknown Error", e)
                events?.endOfStream()

            }
        }
    }

    private fun pairCard(events: EventChannel.EventSink?) {
        NFCHelper.getInstance().waitForCommunication(activity) { communication ->
            Log.i("NFC", "Started")
            events?.success("Connected to card")
            try {
                val manager =
                    BchainManager.build(activity, communication)
                manager.connect() // Connect to card
                events?.success("Fingerprint Verification")
                if (manager.isCardPaired) {
                    events?.success("Card Already Paired")
                    events?.endOfStream()
                    //throw RuntimeException("Card Already Paired")
                } else {
//                val verifyPin = manager.verifyPin(args["pin"].toString())

                    manager.pairCard(pin)
                    if (manager.isCardPaired) {
                        events?.success("Done")
                        events?.success("Card Paired Successfully")
                        events?.endOfStream()
                    } else {
                        events?.success("Card Not Paired")
                        events?.endOfStream()
                    }
                }


            } catch (e: SDKException) {
                e.printStackTrace()
                //events?.error(e.message.toString(), "Unknown Error", e)
                events?.success("Error");
                events?.endOfStream()

            }
        }
    }

    private fun sendTransaction(args: Map<*, *>, events: EventChannel.EventSink?) {
        NFCHelper.getInstance().waitForCommunication(activity) { communication -> // Wait for card
            events?.success("Connected to card")
            try {
                val manager = BchainManager.build(activity, communication)
                manager.connect()

                if (!manager.isCardPaired) {
                    events?.success("Card Not Paired")
                    events?.endOfStream()
                    throw RuntimeException("Card not paired")
                }

//                val cvm = manager.getUserAuthenticationRule()
//                if(cvm == CardStatus.CVM_PIN_AND_BIO_REQUIRED) {
//                    manager.verifyPin(Settings.getCardPin()) // Auth to the card with PIN
//                }

                // Perform signature
                val path = args["bipPath"].toString() //"m/44'/60'/0'/0/0"
                val to = args["to"].toString()
                //val to = "0x84b9B910527Ad5C03A9Ca831909E21e236EA7b06".lowercase() // contract address /For Transaction receipent address
                //val to = "0x8e614fD78B7983f416cB3456bD7DAA7A60AC3fE6".lowercase() // transaction coin
                //val gasPrice = BigInteger(Hex.decode("4A817C800"))
                val gasPrice = BigInteger(Hex.decode(args["gasPrice"].toString()))
                //val gasLimit = BigInteger(Hex.decode("01 0000"))
                val gasLimit = BigInteger(Hex.decode(args["gasLimit"].toString()))
                val value = ValueUnit.Ether(args["value"].toString())
                val nonce = BigInteger(args["nonce"].toString())
                val chainId: Long = args["chainId"] as Long // Ethereum
                //val data = byteArrayOf(0) // transaction
                //val data = Hex.decode("a9059cbb0000000000000000000000008e614fd78b7983f416cb3456bd7daa7a60ac3fe6000000000000000000000000000000000000000000000000000000003b9aca00") // contract address
                val data = Hex.decode(args["data"].toString())

                // Build data
                val transactionData =
                    EthereumTransactionData(to, gasPrice, gasLimit, value, nonce, chainId, data)
                val transactionMessage =
                    EthereumTransaction.generateTransactionMessage(transactionData)
                // coin
                val transactionHash = EthereumTransaction.hashTransactionMessage(transactionMessage)
                //token
                //val transactionHash = EthereumTransaction.hashTransactionMessage(Hex.decode("f86c02850173eed8008504a817c80094ed54a1db1d9e063e51b1291fc929955fd7c27ead80b844a9059cbb0000000000000000000000007e3ec175a03349b356e2d96d1cd706a19022c1020000000000000000000000000000000000000000000000000000000000989680618080"))


                // Signature + verify
                events?.success("Fingerprint Verification")
                val signature = manager.signMessageHash(path, transactionHash)
                val isSignatureValid = manager.verifySignature(path, transactionHash, signature)
                if (!isSignatureValid) {
                    events?.success("Invalid Signature")
                    events?.endOfStream()
                    throw RuntimeException("Card signature not valid")
                }

                // Wrap data + signature
                val wrappedSignatureWithData =
                    EthereumTransaction.wrapSignatureWithTransaction(transactionData, signature)

                Log.i(
                    "DemoSendPresenter",
                    "Transaction data: " + Hex.encode(wrappedSignatureWithData)
                )
//                Log.i("Transaction", "Transaction data: " + Hex.encode(transactionData.data))
                // TODO: send wrappedSignatureWithData to blockchain
                val response: Map<String, Any?> = mapOf(
                    "txData" to Hex.encode(wrappedSignatureWithData),
                )

                events?.success("done")// Notify success
                events?.success(response)
                events?.endOfStream()
            } catch (e: Exception) {
                e.printStackTrace()
                events?.error(e.message.toString(), "Unknown Error", e)
                events?.endOfStream()
            }

        }
    }
}
