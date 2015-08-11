//: Playground - noun: a place where people can play

import UIKit
var str = "Protocol Oriented Programming"

//Reminder: there is a Snippets.swift file inside the bundle

protocol DataSource {
    typealias Element
    
    var elements: [Element] { get set }
    
    func generateElements() -> [Element]
}

class Person {
    var title = "No name"
}

class AppleContact: Person {
    var contactID: Int
    init(id: Int, title: String) {
        self.contactID = id

        super.init()
        self.title = title
    }
}

class GoogleContact: Person {
    var googleID: String
    init(id: String, title: String) {
        self.googleID = id
        
        super.init()
        self.title = title
    }

}

class AppleDataSource: DataSource {
    var elements = [Person]()
    
    func generateElements() -> [Person] {
        var generatedContact = AppleContact(id: Int(count(elements)), title: String("Apple #\(self.elements.count)"))
        elements.append(generatedContact)
        return elements
    }
}

class GoogleDataSource: DataSource {
    var elements = [Person]()
    
    func generateElements() -> [Person] {
        var generatedContact = GoogleContact(id: String("googleID:\(self.elements.count)"), title: String("Google #\(self.elements.count)"))
        elements.append(generatedContact)
        return elements
    }
}

let appleDS = AppleDataSource()
appleDS.generateElements()
appleDS.elements

let googleDS = GoogleDataSource()
googleDS.generateElements()
appleDS.elements

enum DataSourceType {
    case Apple, Google
}


//Protocol with Generic methods
protocol Source {
    func elements<T>(t: T) -> [T]
}

class TestSource: Source {

    func elements<T>(t: T) -> [T] {
        var arr = [T]()
        for _ in 0...3 {
            arr.append(t)
        }
        return arr
    }
}

let tester = TestSource()
tester.elements("Hello")
tester.elements(100)
tester.elements(Person())



//DataSource as a superClass
class GenericDS<T> {
    var elements = [T]()
    func generateElements() -> [T] {
        return []
    }
}

class SubGenericDS<A: Person>: GenericDS<A> {
    func put<A>(a:A) -> A {
        return a
    }
}

let sub = SubGenericDS<AppleContact>()
let sub2 = SubGenericDS<GoogleContact>()
let subs =  [sub, sub2]


struct Media {
    let url: String
}

//class StructGenericDS<T: Media>: GenericDS<T> {
//    override func generateElements() -> [Media] {
//        let media1 = Media(url: "a")
//        let media2 = Media(url: "b")
//        let elems = [media1, media2]
//        self.elements = elems
//        
//        return elements
//    }
//}
//
//let structDS = StructGenericDS<Media>()
//println(structDS.elements)


