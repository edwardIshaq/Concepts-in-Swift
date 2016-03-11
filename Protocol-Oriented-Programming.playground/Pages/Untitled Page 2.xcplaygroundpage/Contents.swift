//: [Previous](@previous)

import Foundation

struct Resource<T> {
    
    let store: T
    init(x: T) {
        store = x
    }
    
    func produce() -> T {
        return store
    }
}

final class Event {
    let name: String
    init(name: String) {
        self.name = name
    }
    
    func resource() -> Resource <Event> {
        return Resource(x: self)
    }
    
    
}

protocol ResourceConvertible  {
    func syncResource() -> Resource<Self>
}

extension Event: ResourceConvertible {
    
    func syncResource() -> Resource<Event> {
        return resource()
    }
}

let event = Event(name: "holiday")
event.syncResource()

var str = "Hello, playground"

public protocol SignalProducerType {
    typealias Value
    typealias Error: ErrorType
    
    init(value: Value)
    
    func checkError() -> Error?
}


public struct SignalProducer<Value, Error: ErrorType> : SignalProducerType {
    let _val: Value
    public init(value: Value) {
        _val = value
    }
    
    public func checkError() -> Error? {
        return nil
    }
}

extension SignalProducer {
    public func combine() -> (Value, Error?) {
        return (_val, nil)
    }
}

//: [Next](@next)
