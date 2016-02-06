//
//  Prof.swift
//  schedulerTest
//
//  Created by Fadi Botros on 2015-11-22.
//  Copyright © 2015 Fadi Botros. All rights reserved.
//

import Foundation

class Prof {
    
    var firstname = ""      //Yousry
    var lastname = ""       //Elsabrouty
    var fullname = ""       //Yousry Elsabrouty
    var href = ""           ///ShowRatings.jsp?tid=21847
    var profID = -1         //2
    var rating = -1.0       //4.8
    var numRatings = 0      //211
    
    init(firstname : String, lastname: String, fullname: String, href: String, profID : Int, rating : Double, numRatings: Int)
    {
        self.firstname = firstname
        self.lastname = lastname
        self.fullname = fullname
        self.href = href
        self.profID = profID
        self.rating = rating
        self.numRatings = numRatings
    }
    
    init(fullname: String)
    {
        self.fullname = fullname
    }
    
    convenience init(dict: NSDictionary)
    {
        let firstname = dict["firstname"] as! String
        let lastname = dict["lastname"] as! String
        let fullname = dict["fullname"] as! String
        let href = dict["href"] as! String
        let profID = dict["profID"] as! Int
        let numRatings = Int(dict["numRatings"] as! String)!
        var rating = 0.0
        
        if(numRatings > 0){
            rating = Double(dict["rating"] as! String)!
        }
        else{
            rating = 0
        }
        
        self.init(firstname: firstname,
            lastname: lastname,
            fullname: fullname,
            href: href,
            profID: profID,
            rating: rating,
            numRatings:  numRatings)
    }
    
    
}