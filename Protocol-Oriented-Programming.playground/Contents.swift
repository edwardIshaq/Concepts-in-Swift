//: Playground - noun: a place where people can play

import UIKit

var str = "Protocol Oriented Programming"


protocol DataSource {
    typealias Element: Hashable
    
    var elements: [Element] { get set }
    
    func elementsSignal() -> [Element]
}

class AppleContact {
    var title = ""
}

class GoogleContact {
    var title = ""
}

class AppleDataSource: DataSource {
    var elements = [AppleContact]()
    func elementsSignal() -> [AppleContact] {
        return elements
    }
}