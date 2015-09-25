import Foundation

//Function Composition
infix operator >>> { associativity left precedence 10 }
public func >>> <A, B, C>(f: B -> C, g: A -> B) -> A -> C {
    return { x in f(g(x)) }
}

infix operator <%> { associativity left precedence 100 }
public func <%><A,B>(f: A->B, x:A) -> B {
    return f(x)
}

