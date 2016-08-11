//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
print("hello there to swift 2.1 programing coures")


56 + 43

71 - 36

23 * 1.75

22.0 / 7

"hello" + "Everyone" + "Welocome to swift"

print("result is good")

let player1 :(String,Int,Bool)
player1 = ("lalal",100,true)
player1.0
player1.1
player1.2


let player2 :(playerName: String , playHighScore: Int, isRegisterd:Bool)
player2 = ("aaaaa",200,true)
player2.playerName
player2.playHighScore
player2.isRegisterd

func tipWarning (){
    print("Tipping at restaurant in this country is mendetory")
}

tipWarning()

func completeName(givenName:String? ,familyName:String?) -> String? {
    guard givenName != nil && familyName != nil  else{
        return nil
    }
    return givenName! + " " + familyName!
}

let myName = completeName(nil, familyName: nil)
let HeName = completeName("Aprove", familyName: "Mote")

struct Restaurant {
    
    let name : String
    
    let houseNumber : Int
    
    let streetNmae : String
    
    let city : String
    
    let state : String
    
    let zipCode : String
    
    func printRessstaurantAddress(){
        print(name)
        print("\(houseNumber)," + streetNmae)
        print(city + "," + state)
        print(zipCode)
    }
}

let  flemings  = Restaurant(name: "Fleming's Stake House" , houseNumber: 227 , streetNmae: "Stuart street", city: "Boston",state: "MA",zipCode: "02116")
    flemings.printRessstaurantAddress()

struct People {
    let name : String
    var age : Int
}

//let  lily  = People(name: "lily", age: 34)

var  lily  = People(name: "lily", age: 34)
lily.age  = 25
//lily.name = "lose"

var randomString = "go ogle"

randomString.hasPrefix("g")
randomString.hasSuffix("gle")
randomString.characters.count
randomString.startIndex
randomString.endIndex
randomString.characters.indexOf("0")
randomString.characters.endIndex
randomString.characters.indices
//randomString.append("f")
let character: Character = "f"
randomString.append(character)
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496

let num = 39
num.distanceTo(1) // 1 - 39
num.advancedBy(-2) // -2 - 39
num.predecessor() //before
num.successor() //next

let greeting = "Guten Tag!"
greeting[greeting.startIndex]
greeting[greeting.endIndex.predecessor()]
greeting[greeting.startIndex.successor()]
let index = greeting.startIndex.advancedBy(2)
greeting[index]
greeting.substringFromIndex(greeting.startIndex.advancedBy(2))

for index in greeting.characters.indices {
    print("\(greeting[index]) ", terminator: "")
}

var welcom = "hello"
welcom.insert("!", atIndex: welcom.endIndex)
welcom.insertContentsOf(" there".characters, at: welcom.endIndex.predecessor())
welcom.removeAtIndex(welcom.endIndex.predecessor())
let range = welcom.endIndex.advancedBy(-6)..<welcom.endIndex
welcom.removeRange(range)


var students:[String] = []
var names = [String]()
var students1 = ["fist","sec","third","four","five"]
    students1 = students1 + ["six","seven"]
    students1.append("eight")
    students1 += ["nine","ten"]
    students1[1] = "1"
    students1[0...3] = ["a","b","c"]
    students1.insert("f", atIndex: 5)
    students1.removeAtIndex(2)
    students1.removeLast()
//    students1.removeAll()

for name in students1.enumerate(){
    print(name)
}
for (index,name) in students1.enumerate(){
    print("index \(index),name \(name)")
}
for name in students1{
    print(name)
}

var dict:[String:Int] = [:]
var example = [String: Int]()
var dialCode = ["USA":1,"UK":44,"India":91]
dialCode["Canada"] = 1
dialCode["Australia"] = 61
print(dialCode)
dialCode["Australia"] = nil
print(dialCode)
dialCode["USA"] = 11
print(dialCode)

var hHex = "123456"
var  range1 = hHex.startIndex..<hHex.startIndex.advancedBy(2)

let rHex = hHex.substringWithRange(range1)

range1 = hHex.startIndex.advancedBy(2) ..< hHex.startIndex.advancedBy(4)
let gHex = hHex.substringWithRange(range1)

range1 = hHex.startIndex.advancedBy(4) ..< hHex.endIndex
let bHex = hHex.substringWithRange(range1)

let strr = String(3,radix:2) //10进制转2进制

var r:CUnsignedInt = 0,g:CUnsignedInt = 0, b:CUnsignedInt = 0

NSScanner(string: rHex).scanHexInt(&r)
NSScanner(string: gHex).scanHexInt(&g)
NSScanner(string: bHex).scanHexInt(&b)
print("r \(r),g \(g),b\(b)")
let color = UIColor(red: CGFloat(r)/255.0,green:CGFloat(g)/255.0,blue: CGFloat(b)/255.0,alpha:1.0)

let lable = UILabel.init(frame: CGRectMake(0, 0, 200,30))
lable.text = "hello "
lable.backgroundColor = UIColor.redColor()


