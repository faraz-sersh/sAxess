//
//  ValueUnit.swift
//  SDK
//
//  Created by Smart Services on 25/05/2023.
//

import Foundation
import BigInt


// Real decimal
public enum ValueUnit {
    case wei(value: String)
    case kwei(value: String)
    case mwei(value: String)
    case gwei(value: String)
    case szabo(value: String)
    case finney(value: String)
    case ether(value: String)
    case kether(value: String)
    case mether(value: String)
    case gether(value: String)
}

public extension ValueUnit {
    
    func getFactor() -> Int {
        switch(self) {
            case .wei: return 0
            case .kwei: return 3
            case .mwei: return 6
            case .gwei: return 9
            case .szabo: return 12
            case .finney: return 15
            case .ether: return 18
            case .kether: return 21
            case .mether: return 24
            case .gether: return 27
        }
    }
    
    func getValue() -> BigUInt {
        switch(self) {
        case .wei(let value): return unitToValue(unit: self, value: value)
        case .kwei(let value): return unitToValue(unit: self, value: value)
        case .mwei(let value): return unitToValue(unit: self, value: value)
        case .gwei(let value): return unitToValue(unit: self, value: value)
        case .szabo(let value): return unitToValue(unit: self, value: value)
        case .finney(let value): return unitToValue(unit: self, value: value)
        case .ether(let value): return unitToValue(unit: self, value: value)
        case .kether(let value): return unitToValue(unit: self, value: value)
        case .mether(let value): return unitToValue(unit: self, value: value)
        case .gether(let value): return unitToValue(unit: self, value: value)
        }
    }
    
    private func unitToValue(unit: ValueUnit, value: String) -> BigUInt {
        let (base, small) = value.toDoubleInt64()
        
        if(base == 0) { return 0 }
        let baseValue = BigUInt(10).power(getFactor()).multiplied(by: BigUInt(base))
        // Calculate new value for minor units
        let stringSmall = String(small)
        let newSmall: String
        if(stringSmall.count > 3) {
            newSmall = "\(stringSmall[0 ..< 3]).\(stringSmall[3 ..< (stringSmall.count)])"
        } else {
            newSmall = "\(stringSmall[0 ..< (stringSmall.count)])"
        }
        //print("  \(value) =>  new small: \(newSmall)")
        
        switch(unit) {
        case .wei: return baseValue
        case .kwei: return baseValue + ValueUnit.wei(value: newSmall).getValue()
        case .mwei: return baseValue + ValueUnit.kwei(value: newSmall).getValue()
        case .gwei: return baseValue + ValueUnit.mwei(value: newSmall).getValue()
        case .szabo: return baseValue + ValueUnit.gwei(value: newSmall).getValue()
        case .finney: return baseValue + ValueUnit.szabo(value: newSmall).getValue()
        case .ether: return baseValue + ValueUnit.finney(value: newSmall).getValue()
        case .kether: return baseValue + ValueUnit.ether(value: newSmall).getValue()
        case .mether: return baseValue + ValueUnit.kether(value: newSmall).getValue()
        case .gether: return baseValue + ValueUnit.mether(value: newSmall).getValue()
        }
    }
    
}

private extension String {
    
    // String float to int64 & int64
    func toDoubleInt64() -> (Int64, Int64) {
        var value = self
        var main = Int64(0)
        var small = Int64(0)

        value = value.replacingOccurrences(of: " ", with: "")
        if(value.contains(".")) {
            let values = value.split(separator: ".")
            main = Int64(values[0]) ?? Int64(-1)
            small = Int64(values[1]) ?? Int64(-1)
        } else if(value.contains(",")) {
            let values = value.split(separator: ",")
            main = Int64(values[0]) ?? Int64(-1)
            small = Int64(values[1]) ?? Int64(-1)
        } else {
            main = Int64(value) ?? Int64(-1)
        }
        
        return (main, small)
    }
    
    var length: Int {
        return count
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
}


