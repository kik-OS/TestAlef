//
//  Parent.swift
//  TestAlef
//
//  Created by Никита Гвоздиков on 02.06.2021.
//

import Foundation

struct Parent {
    var fullName: String?
    var age: Int?
    var children: [Child] = []
}

struct Child {
    var name: String?
    var age: Int?
    let id = UUID()
}

