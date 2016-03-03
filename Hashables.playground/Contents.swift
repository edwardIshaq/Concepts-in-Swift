//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let p1 = 17
let p2 = 23

let p1Dec = NSDecimalNumber(integer: p1)
let p2Dec = NSDecimalNumber(integer: p2)

public func combineHashables<T: Hashable>(xs: [T]) -> Int {
    return Int(combinedHashablesDec(xs))
}

public func combinedHashablesDec<T: Hashable>(xs: [T]) -> NSDecimalNumber {
    return xs.reduce(p1Dec) { (acc, x) -> NSDecimalNumber in
        //return acc * p2 + x
        let accP2 = acc.decimalNumberByMultiplyingBy(p2Dec)
        let decX = NSDecimalNumber(integer: x.hashValue)
        let total = accP2.decimalNumberByAdding(decX)
        
        return total
    }
}

func combineHashes(xs: [Int]) -> Int {
    let combo = xs.reduce(p1) { (acc, x) -> Int in
        return acc * p2 + x
    }
    return combo
}

let testArr = [5, 29, 12]
combineHashes(testArr)
combinedHashablesDec(testArr)
combineHashables(testArr)


//Test combinedHashDec
let str1 = "Eddie"
let hash1 = str1.hashValue

let str2 = "Ishaq"
let hash2 = str2.hashValue

let hashes = [hash1, hash2]
//combineHashes(hashes) -- FAILS
let comboInt = combineHashables(hashes)
combinedHashablesDec(hashes).stringValue

combinedHashablesDec([str1, str2]).stringValue == combinedHashablesDec(hashes).stringValue
combinedHashablesDec([str1, str2]).integerValue == comboInt


let hashDecimal = combinedHashablesDec([str1, str2])
let strHash = hashDecimal.stringValue
strHash.characters.count

Int(hashDecimal)


let decHash = hashDecimal.decimalValue
decHash._exponent
decHash._length
decHash._mantissa
decHash._exponent

UInt64.max
"18446744073709551615".characters.count


Int64.max
Int64.min
NSDecimalNumber(integer: 6)
