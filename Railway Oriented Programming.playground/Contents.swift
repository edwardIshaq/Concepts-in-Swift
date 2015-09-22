//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//Function Composition
infix operator >>> { associativity left precedence 10 }
public func >>> <A, B, C>(f: B -> C, g: A -> B) -> A -> C {
    return { x in f(g(x)) }
}

infix operator <%> { associativity left precedence 100 }
public func <%><A,B>(f: A->B, x:A) -> B {
    return f(x)
}


public enum Result<T> {
    case success(T)
    case failure(ErrorType)
}

enum AppErrors: ErrorType {
    case NameTooShort(String)
    case NameExists(String)
}

var namesDB = [String]()
func validateName(name: String) -> Result<String> {
    if namesDB.contains(name) {
        return Result.failure(AppErrors.NameExists(name))
    }
    
    namesDB.append(name)
    return Result.success(name)
}


validateName("Eddie")
validateName("Eddie")

func validateLength(name: String) -> Result<String> {
    if name.characters.count > 3 {
        return Result.success(name)
    }
    return Result.failure(AppErrors.NameTooShort(name))
}


public func bind<A,B>(switchFuntion: A->Result<B>) -> Result<A> -> Result<B> {
    return { (a: Result<A>) in
        switch a {
        case .success(let x):
            return switchFuntion(x)
            
        case .failure(let error):
            return Result.failure(error)
        }
    }
}

let validate = bind<%>validateLength >>> bind<%>validateName
validate(Result.success("Eddie"))
validate(Result.success("EDY"))
validate(Result.success("aslkjasdlkjdf"))

infix operator >>= { associativity left }
public func >>=<A,B>(twoTrackInput: Result<A>, switchFunction: A->Result<B>) -> Result<B>{
    return bind(switchFunction)(twoTrackInput)
}

func validateRequest(twoTrackInput: Result<String>) -> Result<String> {
    return twoTrackInput
        >>= validateLength
        >>= validateName
}
