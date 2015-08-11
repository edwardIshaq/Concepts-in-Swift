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
let _queryString = urlString.substringFromIndex((queryStartRange?.startIndex)!)


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

extension Array {
    func empty() -> Bool {
        return self.count == 0
    }
    
    var head: Element? {
        get {
            return self.first
        }
    }
    
    var tail: Array<Element>? {
        get {
            if self.empty() { return nil }
            return Array(dropFirst(self))
        }
    }
    

    func foldl<B>(acc: B, f: (B,T)->B) -> B {
        return _foldl(acc, list: self, f: f)
    }
    
    func _foldl<A,B>(acc: B, list: [A], f: (B, A) -> B) -> B {
        if list.empty() { return acc }
        return _foldl(f(acc, list.head!), list: list.tail!, f: f)
    }

}

let clientId = "d46d6144433f456ca7016edc6b0c7e1f"
let baseURL = "https://instagram.com/"
let loginPath = "oauth/authorize"

var ownBaseURL: String {
    return String("ig\(clientId)://authorize")
}


//Arguments
let format = "alt=json"
let maxResults = "max-results=500"
let updatedMin = "updated-min=2000-07-09T00:00:00"
let redirect = "redirect_uri=\(ownBaseURL)"

var args = [format, maxResults, updatedMin, redirect]

var concated = args.foldl(""){ (result, item) in
    return result + "&" + item
}
concated.replaceRange(Range(start: concated.startIndex, end: concated.startIndex.successor()), with: "?")


let queryAllowedSet = NSCharacterSet.URLQueryAllowedCharacterSet()
(concated as NSString).stringByAddingPercentEncodingWithAllowedCharacters(queryAllowedSet)



func queryString(dict: [String: String]) -> String {
    let queryAllowedSet = NSCharacterSet.URLQueryAllowedCharacterSet()

    let queries = reduce(dict, [String]()) { (accum: [String], elem: (key: String, value: String)) -> [String] in
        let additionalQuery = String("\(elem.key)=\(elem.value)")
        if let encodedQuery = (additionalQuery as NSString).stringByAddingPercentEncodingWithAllowedCharacters(queryAllowedSet) {
            var copy = accum
            copy.append(encodedQuery as String)
            return copy
        }
        return accum
    }
    
    var concated = queries.foldl(""){ (result, item) in
        return result + (count(result) > 0 ? "&" : "") + item
    }

    return concated
}

let params = ["client_id" : clientId,
    "response_type": "token",
    "redirect_uri": ownBaseURL,
    "scope" : "basic"]

let query = queryString(params)


let urlComp = NSURLComponents()
urlComp.scheme = "http"
urlComp.host = "instagram.com"
urlComp.path = "/oauth/authorize"
urlComp.query = query

urlComp.URL


let fragment = "access_token=18235201.d46d614.2608bd9fe15e478e95fd5c42689a94fe&var2=xxx&var3=yyy"
let responseParams = (fragment as NSString).componentsSeparatedByString("&") as? [String]
println(responseParams)
let reponseDict = responseParams?.reduce([String:String](), combine: { (dict: [String:String], param: String) -> [String:String] in
    let splitParams = (param as NSString).componentsSeparatedByString("=") as! [String]
    println( ">> \(splitParams)")
    var acc = dict
    if count(splitParams) == 2 {
        acc[splitParams[0]] = splitParams[1]
    }
    
    return acc
    
})

reponseDict



let maybeString: String? = "test"
let emptyString: String? = nil

func doubleMe(str: String) -> String {
    return String("\(str) \(str)")
}

let testFlatMap = maybeString.map(doubleMe)
println(testFlatMap)
emptyString.map(doubleMe)


