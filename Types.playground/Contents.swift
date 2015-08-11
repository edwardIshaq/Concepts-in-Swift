//: Playground - noun: a place where people can play

import UIKit

class VC1: UIViewController {}

class VC2: UIViewController {}

let tabBar = UITabBarController()
tabBar.viewControllers = [VC1(), VC2()]

extension UITabBarController {
    
    public func viewControllerInfo<T: UIViewController>(ofType: T.Type) -> (viewController: T,index: Int)? {
        if let tabViewControllers = self.viewControllers{
            println(tabViewControllers)
            for  (idx, maybeVCTypeT) in enumerate(tabViewControllers) {
                if let viewController = maybeVCTypeT as? T {
                    println("\(viewController) supposed to be: \(T.self)")
                    return (viewController, idx)
                }
            }
            
        }
        return nil
    }
    

    public func viewControllerInfo2<T: UIViewController>(ofType: T.Type) -> (viewController: T,index: Int)? {
        if let tabViewControllers = self.viewControllers{
            for  (idx, maybeVCTypeT) in enumerate(tabViewControllers) {
                if maybeVCTypeT is T {
                    return (maybeVCTypeT as! T, idx)
                }
            }
            
        }
        return nil
    }
    
    public func viewControllerInfo3<T: UIViewController>(ofType: T.Type) -> (viewController: T,index: Int)? {
        if let tabViewControllers = self.viewControllers{
            for  (idx, maybeVCTypeT) in enumerate(tabViewControllers) {
                if maybeVCTypeT.isKindOfClass(T) {
                    return (maybeVCTypeT as! T, idx)
                }
            }
            
        }
        return nil
    }
    
    /*
    This version works because:
    There is no constraint of <T: UIViewController> which breaks the `is` test
    http://www.openradar.me/22218124
    */
    public func viewControllerInfo4<T>(ofType: T.Type) -> (viewController: T,index: Int)? {
        if let tabViewControllers = self.viewControllers{
            for  (idx, maybeVCTypeT) in enumerate(tabViewControllers) {
                if let viewController = maybeVCTypeT as? T {
                    println("\(viewController) supposed to be: \(T.self)")
                    return (viewController, idx)
                }
            }
            
        }
        return nil
    }

}

//Using viewControllerInfo
if let (vc, idx) = tabBar.viewControllerInfo(VC1.self) {
    println(vc)
}

if let (vc, idx) = tabBar.viewControllerInfo(VC2.self) {
    println(vc)
}

//viewControllerInfo2
if let (vc, idx) = tabBar.viewControllerInfo2(VC1.self) {
    println(vc)
}

if let (vc, idx) = tabBar.viewControllerInfo2(VC2.self) {
    println(vc)
}

//viewControllerInfo3
if let (vc, idx) = tabBar.viewControllerInfo3(VC1.self) {
    println(vc)
}

if let (vc, idx) = tabBar.viewControllerInfo3(VC2.self) {
    println(vc)
}

//viewControllerInfo4 Works, see func signature notes
if let (vc, idx) = tabBar.viewControllerInfo4(VC1.self) {
    println(vc)
}

if let (vc, idx) = tabBar.viewControllerInfo4(VC2.self) {
    println(vc)
}




let testVC1 = VC1()

if testVC1 is VC2 {
    println("\(testVC1) is \(VC2.self)")
}


let myArray: [AnyObject] = [VC2(), VC1()]
for (idx, x) in enumerate(myArray) {
    println(x)
    if let xAsVC1 = x as? VC1 {
        println("\(x) is supposed to be \(VC1.self)")
    }
    
    if x is VC2 {
        println("\(x) is supposed to be \(VC2.self)")
    }
}



//Sharing Base class and protocol Objc: NSObject<Protocol>

protocol ProtoTest {
    var foo: Int { get set }
}


class AClass: NSObject,  ProtoTest {
    var foo: Int = 3
}


class BClass: NSObject,  ProtoTest {
    var foo: Int = 4
}

class Consumer {
    
    var protoInstance: ProtoTest?  //Does not cary any information of the class just the protocol
    var protoInstance2: protocol<NSObjectProtocol, ProtoTest>?
    
    init(x: ProtoTest) {
        self.protoInstance = x
        self.protoInstance2 = nil
    }
    
    init(x: protocol<NSObjectProtocol, ProtoTest>) {
        self.protoInstance2 = x
        self.protoInstance = nil
    }
    
    func doSomethingWith(object: NSObject) -> String {
        return object.description
    }
    
    func doSomething() -> String? {
        if let x = protoInstance as? NSObject {
            let result = doSomethingWith(x)
            return result
        }
        if let x = protoInstance {
//            x.copy() //'ProtoTest' does not have a member named 'copy'
        }
        if let x = protoInstance2 {
//            x.copy()    //protocol<NSObjectProtocol, ProtoTest> does not have a member named 'copy'
            
        }
        return nil
    }
}


let myConsumer = Consumer(x: AClass())
myConsumer.doSomething()


