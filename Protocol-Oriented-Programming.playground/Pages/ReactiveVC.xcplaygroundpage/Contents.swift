//: [Previous](@previous)

import Foundation
import UIKit

var str = "Hello, playground"


protocol ReactiveVC {
    typealias ViewModelType
    var viewModel: ViewModelType { get set }
}


class TestViewModel {
    let title = "String"
}

class MyVC: UIViewController, ReactiveVC  {
    var viewModel = TestViewModel()
}


class Event {
    let title: String = ""
}

protocol EventViewModel {
    var event: Event? { get set}
}

protocol ReactiveEventViewController {
    typealias ViewModelType: EventViewModel
    var viewModel: ViewModelType { get }
}

class EventLocationViewModel: EventViewModel {
    var event: Event?
}

class EventLocationVC: UIViewController, ReactiveEventViewController  {
    let viewModel = EventLocationViewModel()
}



//: [Next](@next)
