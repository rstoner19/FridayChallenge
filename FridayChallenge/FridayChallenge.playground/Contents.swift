//: Playground - noun: a place where people can play

import UIKit

// Rick, Jeremy, and Jake

//: Playground - noun: a place where people can play

import UIKit

let test = "test"

let datasize = 1000
var uRLKey = [String : String]()
var uniqueKeys = [String : Bool]()
var uRLStack = [String]()
var hashValueTruncater = 99

func base64(url: String) -> String? {
    
    let URL = url.hashValue % hashValueTruncater
    let utf8URL = String(URL).dataUsingEncoding(NSUTF8StringEncoding)
    let base64URL = utf8URL?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    let customLink = "http://" + base64URL!
    
    if uniqueKeys[customLink] == nil {
        uniqueKeys[customLink] = true
        return customLink
    } else {
        base64(customLink)
        hashValueTruncater = hashValueTruncater * 10
    }
    return customLink
}

func shortenURL(uRL: String) -> String? {
    
    if uRLKey[uRL] == nil {
        
        guard let customLink = base64(uRL) else { return nil }
        uRLKey[uRL] = customLink
        uRLStack.append(uRL)
        
        if uRLStack.count > datasize {
            uniqueKeys[uRLKey[uRLStack[0]]!] = nil
            uRLKey[uRLStack.removeFirst()] = nil
        }
        
        return customLink
        
    } else {
        guard let customLink = uRLKey[uRL] else { return nil }
        
        for index in 0..<uRLStack.count {
            if uRLStack[index] == uRL {
                uRLStack.append(uRLStack.removeAtIndex(index))
            }
        }
        return customLink
    }
}


let shortVersion = shortenURL("http://test.com")
//shortenURL("http://test1.com")
//shortenURL("http://test2.com")
//shortenURL("http://test3.com")
//shortenURL("http://test4.com")
//shortenURL("http://test.com")
//shortenURL("http://test4.com")
//shortenURL("http://test10.com")
//shortenURL("http://test7.com")
//shortenURL("http://test4.com")

for number in 0...100{
    shortenURL("http://test\(number).com")
    
}

for (key, value) in uRLKey {
    print("key: \(key) value:", value)
}
for value in uRLStack {
    print(value)
}

