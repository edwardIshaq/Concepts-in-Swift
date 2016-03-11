//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

public typealias PrimaryKey = String

public protocol PrimaryKeyConvertible {
    var pkValue : PrimaryKey { get }
    static func pkObject(key: PrimaryKey) -> Self?
}

public protocol SignalProducerType {
    /// The type of values being sent on the producer
    typealias Value
    /// The type of error that can occur on the producer. If errors aren't possible
    /// then `NoError` can be used.
    typealias Error : ErrorType
    /// Extracts a signal producer from the receiver.
//    public var producer: ReactiveCocoa.SignalProducer<Self.Value, Self.Error> { get }
    /// Creates a Signal from the producer, passes it into the given closure,
    /// then starts sending events on the Signal when the closure has returned.
//    public func startWithSignal(@noescape setUp: (ReactiveCocoa.Signal<Self.Value, Self.Error>, Disposable) -> ())
    
    var value: Value { get }
}


extension SignalProducerType where Value == [PrimaryKeyConvertible] {

    func convert() -> Self {
        let xs = self.value
        let keys = xs.map{ (x: PrimaryKeyConvertible) -> PrimaryKey in
                return x.pkValue
            }
        let xs2 = keys.map{ pk in
//            return Value.Element.pkObject(pk)
/*Playground execution failed: PrimaryKeyConvertible.xcplaygroundpage:38:26: error: static member 'pkObject' cannot be used on instance of type 'PrimaryKeyConvertible.Protocol'
return Value.Element.pkObject(pk)
~~~~~~^~~~~~~ ~~~~~~~~
*/
        }

        return self
    }
}
//: [Next](@next)
