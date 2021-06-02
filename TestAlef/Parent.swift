//
//  Parent.swift
//  TestAlef
//
//  Created by Никита Гвоздиков on 02.06.2021.
//

import Foundation

struct Parent {
    let fullName: String?
    let age: Int?
    var children: [Child]
    
    
   static func getParent() -> Parent {
        Parent(fullName: "", age: 0, children: [])
    }
}

struct Child {
    let name: String?
    let age: Int?
}

