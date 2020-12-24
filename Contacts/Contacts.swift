//
//  Contacts.swift
//  Contacts
//
//  Created by Terechshenkov Andrey on 12/10/20.
//

import Foundation

enum Honorific: String {
    case mr = "Mr."
    case mrs = "Mrs."
    case miss = "Miss"
    case ms = "Ms."
    case mx = "Mx."
    case dr = "Dr."
    case lady = "Lady"
    case lord = "Lord"
}
    
struct Contact {
    var image: String?
    var honorific: String?
    var firstName: String
    var lastName: String?
    var phone: String
    var favourite: Bool = false
    
    var fullName: String {
        get {
            var fullName = firstName
            if let honorific = honorific {
                fullName = honorific + " " + fullName
            }
            if let lastName = lastName {
                fullName += " " + lastName
            }
            return fullName
        }
    }
    
    mutating func switchFavourite() {
        favourite = !favourite
    }
    
    static var contacts: [Contact] {
        get {[
            Contact(image: "sheldon", honorific: Honorific.dr.rawValue, firstName: "Sheldon", lastName: "Cooper", phone: "+138847366738", favourite: false),
            Contact(image: "penny", honorific: Honorific.miss.rawValue, firstName: "Penny", phone: "+124238420939", favourite: true),
            Contact(image: "leonard", honorific: Honorific.dr.rawValue, firstName: "Leonard", lastName: "Hofstadter", phone: "+1388400388", favourite: true),
            Contact(image: "howard", honorific: Honorific.mr.rawValue, firstName: "Howard", lastName: "Wolowitz", phone: "+18283776262", favourite: false),
            Contact(image: "raj", honorific: Honorific.dr.rawValue, firstName: "Raj", lastName: "Koothappali", phone: "+19923737474", favourite: true),
            Contact(image: "amy", honorific: Honorific.dr.rawValue, firstName: "Amy", lastName: "Farrah Fowler", phone: "+129883743839", favourite: false),
            Contact(image: "bernadette", honorific: Honorific.dr.rawValue, firstName: "Bernadette", lastName: "Rostenkowski-Wolowitz", phone: "+1230843884", favourite: true),
            Contact(image: "bert", honorific: Honorific.dr.rawValue, firstName: "Bertram", lastName: "Kibbler", phone: "+1230843884", favourite: false)
        ]}
    }
}
