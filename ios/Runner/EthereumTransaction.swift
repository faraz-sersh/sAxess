//
//  EthereumTransaction.swift
//  Runner
//
//  Created by FARAZ AHMED on 22/10/2024.
//


import BigInt
import Foundation
import SDK
import SwiftKeccak


public struct EthereumTransaction {
    public let to: EthereumAddress
    public let value: BigUInt
    public let data: Data?
    public var nonce: Int64
    public let gasPrice: BigUInt
    public let gasLimit: BigUInt
    public var chainId: Int64?
    

    public init(to: EthereumAddress, value: BigUInt, data: Data?, nonce: Int64, gasPrice: BigUInt, gasLimit: BigUInt, chainId: Int64?) {
        self.to = to
        self.value = value
        self.data = data ?? Data()
        self.nonce = nonce
        self.gasPrice = gasPrice
        self.gasLimit = gasLimit
        self.chainId = chainId
    }

    public var raw: Data? {
        if chainId != nil {
            let txArray: [Any?] = [nonce, gasPrice, gasLimit, to, value, data, chainId, 0, 0]
            return RLP.encode(txArray)
        } else {
            let txArray: [Any?] = [nonce, gasPrice, gasLimit, to, value, data]
            return RLP.encode(txArray)
        }
    }
    
    public static func hashTransaction(_ data: Data) -> Data {
        return SwiftKeccak.keccak256(data)
    }

}

public struct SignedTransaction {
    public let transaction: EthereumTransaction
    public let signature: SignedData

    public init(transaction: EthereumTransaction, signature: SignedData) {
        self.transaction = transaction
        self.signature = signature
    }


    public var raw: Data? {
        let txArray: [Any?]
        if let chainId = transaction.chainId {
            txArray = [transaction.nonce,
                                   transaction.gasPrice,
                                   transaction.gasLimit,
                                   transaction.to,
                                   transaction.value,
                                   transaction.data,
                                   signature.getV(forChainId: chainId),
                                   signature.getR(),
                                   signature.getS()]
        } else {
            txArray = [transaction.nonce,
                                   transaction.gasPrice,
                                   transaction.gasLimit,
                                   transaction.to,
                                   transaction.value,
                                   transaction.data,
                                   signature.getV(),
                                   signature.getR(),
                                   signature.getS()]
        }
        
        // nonce == 0 ?
        // test no chain id
        
        return RLP.encode(txArray)
    }
    
}
