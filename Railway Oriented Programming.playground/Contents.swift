//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

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

public func map<A,B>(singleTrack: A -> B) -> Result<A> -> Result<B> {
    return { (twoTrack: Result<A>) in
        switch twoTrack {
        case .success(let x):
            return Result.success(singleTrack(x))
            
        case .failure(let error):
            return Result.failure(error)
        }
    }
}

func capitalize(name: String) -> String {
    if name.characters.count == 0 {
        return name
    }
    var nameOfString = name
    nameOfString.replaceRange(nameOfString.startIndex...nameOfString.startIndex, with: String(nameOfString[nameOfString.startIndex]).capitalizedString)
    return nameOfString
}

capitalize("")
capitalize("a")
capitalize("ab")
capitalize("3b")

map(capitalize)

public func tee<A>(deadEndFunction: A->()) -> A -> A {
    return { x in
        deadEndFunction(x)
        return x
    }
}


func log(x: Any) {
    print(x)
}

let tLog = tee(log)

let test = tLog("asdlkj")

struct Person {
    let name: String
    let age: Int
}

enum InputError: ErrorType {
    case InputMissing
    case AgeIncorrect
}

func createPerson(name: String?, age: String?) throws -> Person {
    guard let age = age, let name = name
        where name.characters.count > 0 && age.characters.count > 0
        else {
            throw InputError.InputMissing
    }
    
    guard let ageFormatted = Int(age) else {
        throw InputError.AgeIncorrect
    }
    
    return Person(name: name, age: ageFormatted)

}

do {
    let person = try createPerson("1", age: "5*65")
}
catch let error {
    print(error, terminator: "")
}

if let person = try? createPerson("1", age: "65") {
    print(person)
}
else {
    print("failed to create a person")
}

func lift<A,B>(f: A throws -> B ) -> A -> Result<B> {
    return { a in
        do {
            let b = try f(a)
            return Result.success(b)
        }
        catch let error {
            print(error)
            return Result.failure(error)
        }
    }
}

let liftedCreate = lift(createPerson)

liftedCreate(("",""))

