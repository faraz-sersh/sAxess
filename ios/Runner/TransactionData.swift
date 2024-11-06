//
//  TransactionData.swift
//  Runner
//
//  Created by FARAZ AHMED on 22/10/2024.
//


import Foundation
import BigInt


public class TransactionData {
    private let to: String
    private let gasPrice: BigUInt
    private let gasLimit: BigUInt
    private let value: BigUInt
    private let nonce: Int64
    private let chainId: Int64?
    private let data: Data?
    
    
    public init(to: String, gasPrice: BigUInt, gasLimit: BigUInt, value: BigUInt, nonce: Int64, chainId: Int64?, data : Data?) {
        self.to = to
        self.gasPrice = gasPrice
        self.gasLimit = gasLimit
        self.value = value
        self.nonce = nonce
        self.chainId = chainId
        self.data = data
        
    }
    
    public func getTo() -> String {
        return to
    }
    
    public func getGasPrice() -> BigUInt {
        return gasPrice
    }
    
    public func getGasLimit() -> BigUInt {
        return gasLimit
    }
    
    public func getValue() -> BigUInt {
        return value
    }
    
    public func getNonce() -> Int64 {
        return nonce
    }
    
    public func getChainId() -> Int64? {
        return chainId
    }
    public func getData() -> Data? {
        return data
    }
    
    public func toRaw() -> EthereumTransaction {
        let to = EthereumAddress(to)
        return EthereumTransaction(to: to,
                                   value: value,
                                   data: data,
                                   nonce: nonce,
                                   
                                   gasPrice: gasPrice,
                                   gasLimit: gasLimit,
                                   chainId: chainId)
    }
    
}

