// Playground - noun: a place where people can play

import UIKit

var str = "URL Tests"

let url = NSURL(string: "Reminders://Reminder/123/Edit")!

url.path

url.baseURL
url.fragment
url.host


if let args = url.pathComponents as? [String] {
    let filtered = args.filter { (comp:String) in
        comp != "/"
    }
    filtered
}

let contacts = NSURL(string: "https://www.google.com/m8/feeds/contacts/edward.ishaq%40gmail.com/thin?alt=json&start-index=26&max-results=25")!
let urlString = contacts.absoluteString!
let queryStartRange = urlString.rangeOfString("&", options: NSStringCompareOptions.LiteralSearch, range: nil, locale: nil)
queryStartRange?.endIndex
urlString.endIndex
let queryString = urlString.substringFromIndex((queryStartRange?.startIndex)!)


extension NSURL {
    func queryString() -> String? {
        if let urlString = self.absoluteString,
            let queryStartRange = urlString.rangeOfString("?", options: NSStringCompareOptions.LiteralSearch, range: nil, locale: nil){
                let queryString = urlString.substringFromIndex(queryStartRange.startIndex)
                return queryString
        }
        return nil
    }
}

println(contacts.queryString())



func getContacts() -> [String] {
    var page: Int? = 0

    var completeResult = [String]()
    
    do {
        let (result, np) = getContacts(page!)
        completeResult += result

        page = np
        
    }while page != nil
    
    return completeResult
}

func getContacts(page: Int) -> (result:[String], nextPage:Int?) {
    switch page {
    case 0:
        return (["a1","a2","a3"],1)
        
    case 1:
        return (["b1","b2","b3"],2)
        

    case 2:
        return (["c1","c2","c3"],3)
        

    case 3:
        return (["d1","d2","d3"],4)
        

    default:
        return ([],nil)
    }
}

getContacts()
