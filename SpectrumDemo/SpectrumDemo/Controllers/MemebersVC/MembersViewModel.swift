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

    /// Filtering the Members based on the user search input. The filiter performed basded on Member Name.
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

    /// Store and refresh the members list view with updated data source.
    ///
    /// - Parameters:
    ///   - members: list of members.
    private func updateMembersViewDataSource(_ members: Array<Member>?) {
        dataSource = members
        self.delegate?.refreshMembersView()
    }

}
