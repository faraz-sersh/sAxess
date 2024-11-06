//
//  EthereumAddress.swift
//  Runner
//
//  Created by FARAZ AHMED on 22/10/2024.
//

import BigInt
import Foundation


public struct EthereumAddress {
    private let raw: String
    private let numberRepresentation: BigUInt?

    
    public init(_ value: String) {
        self.raw = value.lowercased()
        self.numberRepresentation = BigUInt(raw)
    }
    
    func asString() -> String {
        raw
    }

    func asNumber() -> BigUInt? {
        numberRepresentation
    }

    public static func == (lhs: EthereumAddress, rhs: EthereumAddress) -> Bool {
        guard let lhsInt = lhs.asNumber(), let rhsInt = rhs.asNumber() else {
            return false
        }
        // Comparing Number representation avoids issues with lowercase and 0-padding
        return lhsInt == rhsInt
    }
    
}
