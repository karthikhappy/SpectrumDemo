//
//  MembersViewModel.swift
//  SpectrumDemo
//
//  Created by nxgdev156 on 06/06/2020.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import Foundation


/// MembersViewable helps to refresh the list view in MembersVC with updated data source.
protocol MembersViewable: class {
    func refreshMembersView()
}

class MembersViewModel {
    
    // Holds the company iformation and all members
    private var company: Company?
   
    // The updated data soruce based on user actions filter, sorting.
    private var dataSource: Array<Member>?

    /// MembersViewable helps to refresh the list view in MembersVC
    public weak var delegate: MembersViewable?

   
    public func setCompany(_ companyInfo: Company) {
        self.company = companyInfo
        self.dataSource = companyInfo.members
    }
    
    /// It always retruns updated data source based on user actions filter or sorting.
    ///
    /// - Return:
    /// list of companies
    public func getDataSource() -> Array<Member>? {
        return dataSource
    }

    /// Filtering members with Name.
    ///
    /// - Parameters:
    ///   - searchText: text to filter members with member name
    public func filiterMembers(_ searchText: String) {
        
        // Display all members If search text becomes empty.
        guard !searchText.isEmpty else {
            self.updateMembersViewDataSource(self.company?.members)
            return
        }
        
        guard let memberlist = self.company?.members else { return }
        let foundMembers = memberlist.filter { ($0.name?.first?.contains(searchText) ?? false) }
        self.updateMembersViewDataSource(foundMembers)
    }

    /// Sort members based on drop down selection. It has options - All, sort by name,  sort by Age and favourite
    ///
    /// - Parameters:
    ///   - index: dropdown selection option
    public func sortMembersWith(index: Int) {
        let dropDownOption = MemberFilters.allCases[index]
        var sortedMembers: Array<Member>?
        switch dropDownOption {
        case .allmembers:
            sortedMembers = company?.members
        case .name:
             sortedMembers = sortMembersWithName()
        case .age:
             sortedMembers = sortMembersWithAge()
        case .favorites:
            sortedMembers = filterFavouriteMembers()
        }
         
        self.updateMembersViewDataSource(sortedMembers)
    }

    /// Sort members by name. This is performed based on first name.
    private func sortMembersWithName() -> Array<Member>? {
        guard let members = company?.members else { return [] }
        
        let foundCompaines = members.sorted {
            var isSorted = false
            if let first = $0.name?.first, let second = $1.name?.first {
                isSorted = first < second
            }
            return isSorted
        }
        return foundCompaines
    }
    
    /// Sort members by Age.
    private func sortMembersWithAge() -> Array<Member>? {
        guard let members = company?.members else { return [] }
        
        let foundCompaines = members.sorted {
            var isSorted = false
            if let first = $0.age, let second = $1.age {
                isSorted = first < second
            }
            return isSorted
        }
        return foundCompaines
    }

    /// Filter Favourite Members
    private func filterFavouriteMembers() -> Array<Member>? {
        guard let members = dataSource else { return [] }
        let favouriteMembers = members.filter { ($0.isFavorite == true) }
        return favouriteMembers
    }

    /// Mark Member as favourite or unfavourite
    public func markMemberFavouriteAt(index: Int, isFavourite: Bool) {
        guard let datasourceList = dataSource  else { return }
        let currentMember = datasourceList[index]
        currentMember.isFavorite = isFavourite
    }

    /// Store and refresh the members list view with updated data source.
    ///
    /// - Parameters:
    ///   - members: list of members.
    private func updateMembersViewDataSource(_ members: Array<Member>?) {
        dataSource = members
        self.delegate?.refreshMembersView()
    }

}
