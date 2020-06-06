//
//  ViewController.swift
//  SpectrumDemo
//
//  Created by nxgdev156 on 06/06/2020.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import UIKit

let companyCellIdentifier = "CompanyCell"
let storyBoardName = "Main"
let memberVCIndentifier = "MembersVC"

class CompaniesVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, CompaniesViewable {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: CompaniesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CompaniesViewModel()
        viewModel?.delegate = self as CompaniesViewable

        addleftBarButtonItem()
        
        // Fetch Company list from sever.
        viewModel?.fetchCompanies()
    }

    override func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Filter companies with search text
        viewModel?.filiterCompanies(searchText)
    }
    
    override func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        super.searchBarTextDidEndEditing(searchBar)
         // Make search text empty then the view model will fresh table view with all companies.
        viewModel?.filiterCompanies("")
    }
}

extension CompaniesVC {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel?.getDataSource()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let companyCell: CompanyCell = tableView.dequeueReusableCell(withIdentifier: companyCellIdentifier, for: indexPath) as! CompanyCell
        if let companyList =  viewModel?.getDataSource() {
            companyCell.setCompanyDetails(company: companyList[indexPath.row])
        }
        return companyCell
    }
}

extension CompaniesVC {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let companyList = viewModel?.getDataSource() {
            navigateToMemberVC(company: companyList[indexPath.row])
        }
    }
    
    func navigateToMemberVC(company: Company) {
    }
}

extension CompaniesVC {
    func refreshCompaniesView() {
        DispatchQueue.main.async {
           self.tableView.reloadData()
        }
    }
}
