//
//  MembersVC.swift
//  SpectrumDemo
//
//  Created by nxgdev156 on 06/06/2020.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import UIKit

let memberCellIdentifier = "MemberCell"

class MembersVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
   
    private lazy var viewModel: MembersViewModel = {
        return MembersViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    public func setComany(_ company: Company) {
        viewModel.setCompany(company)
    }
    
    override func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Filter members with search text
        viewModel.filiterMembers(searchText)
    }
    
    override func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        super.searchBarTextDidEndEditing(searchBar)
         // Make search text empty then the view model will fresh table view with all members.
        viewModel.filiterMembers("")
    }

    //MARK: Sorting DropDown
    override public func dropDowndidSelectAtIndex(index: Int, item: String)  {
        // Sort Members based on drop dow selection
        viewModel.sortMembersWith(index: index)
    }

    override public func dropDownDataSource() -> Array<String>? {
        return MemberFilters.allCases.map { $0.rawValue }
    }

}

extension MembersVC: UITableViewDataSource, UITableViewDelegate  {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDataSource()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let memberCell: MemberCell = tableView.dequeueReusableCell(withIdentifier: memberCellIdentifier, for: indexPath) as! MemberCell
        if let members = viewModel.getDataSource() {
            memberCell.setMemberDetails(member: members[indexPath.row])
        }
        return memberCell
    }
}

extension MembersVC : MembersViewable {

    func refreshMembersView() {
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
    }
}
