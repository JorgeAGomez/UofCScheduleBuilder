//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

var i : Int = 13

func addP(inout ref: Int){
    ref++
}
func addP2(var k: Int){
    k += 1
}

print(i)
addP(&i)
print(i)


class number{
    var inout i: Int
    init(inout i: Int)
    {
        self.i=i
    }
    
    func addP(){
        &i++
    }
}

var n = number(i: &i)

addP(&n.i)

print(i)
print(i)


