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
