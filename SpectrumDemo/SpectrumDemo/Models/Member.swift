//
//  Member.swift
//  SpectrumDemo
//
//  Created by nxgdev156 on 06/06/2020.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import Foundation

struct Member: Codable {
    var _id: String?
    var phone: String?
    var name: Name?
    var email: String?
    var age: Int?
    var isFavorite: Bool?
}

struct Name: Codable {
    var first: String?
    var last: String?
}
