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

//: [Next](@next)
