//
//  Company.swift
//  SpectrumDemo
//
//  Created by nxgdev156 on 06/06/2020.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import Foundation

struct Company: Codable {
    var _id: String?
    var company: String?
    var website: String?
    var members: Array<Member>?
    var about: String?
    var logo: String?
    var isFavorite: Bool?
}
