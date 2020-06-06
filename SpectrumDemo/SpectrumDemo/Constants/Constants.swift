//
//  Constants.swift
//  SpectrumDemo
//
//  Created by nxgdev156 on 06/06/2020.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import Foundation

enum CompanyFilters: String, CaseIterable {
    case allCompanies = "All"
    case name = "Name"
    case favorites = "Favorites"
}

enum MemberFilters: String, CaseIterable {
    case allmembers = "All"
    case name = "Name"
    case age = "Age"
    case favorites = "Favorites"
}
