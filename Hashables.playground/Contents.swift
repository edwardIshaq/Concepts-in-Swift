//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let p1 = 17
let p2 = 23

let p1Dec = NSDecimalNumber(integer: p1)
let p2Dec = NSDecimalNumber(integer: p2)

public func combineHashables<T: Hashable>(xs: [T]) -> Int {
    return Int(combineHashablesDec(xs))
}

public func combineHashablesDec<T: Hashable>(xs: [T]) -> NSDecimalNumber {
    return xs.reduce(p1Dec) { (acc, x) -> NSDecimalNumber in
        //return acc * p2 + x
        let accP2 = acc.decimalNumberByMultiplyingBy(p2Dec)
        let decX = NSDecimalNumber(integer: x.hashValue)
        let total = accP2.decimalNumberByAdding(decX)
        
        return total
    }
}

extension Array where Element: Hashable {
    public func combinedHash() -> Int {
        return combineHashables(self)
    }
}

func combineSmallHashes(xs: [Int]) -> Int {
    let combo = xs.reduce(p1) { (acc, x) -> Int in
        return acc * p2 + x
    }
    return combo
}

let testArr = [5, 29, 12]

combineSmallHashes(testArr) == combineHashablesDec(testArr)
combineHashables(testArr) == combineHashablesDec(testArr)


//Test combinedHashDec
let str1 = "Eddie"
let hash1 = str1.hashValue

let str2 = "Ishaq"
let hash2 = str2.hashValue

let strings = [str1, str2]
let hashes = strings.map{ $0.hashValue }

//Test some functions

//combineHashes(hashes) // FAILS
combineHashables(hashes)
combineHashablesDec(hashes).stringValue
combineHashablesDec(hashes).integerValue

combineHashablesDec(strings).integerValue == combineHashables(hashes)

strings.combinedHash() == combineHashables(hashes)

