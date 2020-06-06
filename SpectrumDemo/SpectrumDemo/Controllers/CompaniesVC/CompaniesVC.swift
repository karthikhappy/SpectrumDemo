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

class CompaniesVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel: CompaniesViewModel = {
        return CompaniesViewModel()
    }()

    private lazy var activityView: ActivityView? = {
        return ActivityView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self as CompaniesViewable

        addleftBarButtonItem()
        
        activityView?.showIndicator()
        
        // Fetch Company list from sever.
        viewModel.fetchCompanies()
    }

    override func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Filter companies with search text
        viewModel.filiterCompanies(searchText)
    }
    
    override func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        super.searchBarTextDidEndEditing(searchBar)
         // Make search text empty then the view model will fresh table view with all companies.
        viewModel.filiterCompanies("")
    }
   
    //MARK: Sorting DropDown
    override public func dropDowndidSelectAtIndex(index: Int, item: String)  {
        // Sort companies based on drop down selection.
        viewModel.sortCompaniesWith(index: index)
    }

    override public func dropDownDataSource() -> Array<String>? {
        return CompanyFilters.allCases.map { $0.rawValue }
    }
}

extension CompaniesVC: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.getDataSource()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let companyCell: CompanyCell = tableView.dequeueReusableCell(withIdentifier: companyCellIdentifier, for: indexPath) as! CompanyCell
        companyCell.delegate = self
        if let companyList =  viewModel.getDataSource() {
            companyCell.setCompanyDetailsAt(index: indexPath.row, company: companyList[indexPath.row])
        }
        return companyCell
    }
}

extension CompaniesVC: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let companyList = viewModel.getDataSource() {
            navigateToMemberVC(company: companyList[indexPath.row])
        }
    }
    
    func navigateToMemberVC(company: Company) {
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        let membersVC: MembersVC = storyBoard.instantiateViewController(identifier: memberVCIndentifier)
        membersVC.setComany(company)
        navigationController?.pushViewController(membersVC, animated: true)
    }
}

extension CompaniesVC: CompaniesViewable {
    
    func refreshCompaniesView() {
        DispatchQueue.main.async { [weak self] in
           self?.tableView.reloadData()
        }
    }
    
    func hideActivityView()  {
       DispatchQueue.main.async { [weak self] in
          self?.activityView?.hideIndicator()
          self?.activityView = nil
       }
    }
}

extension CompaniesVC: CompanyCellEditable {
   
    func markFavouriteCompany(isFavourite: Bool, index: Int) {
        viewModel.markCompanyFavouriteAt(index: index, isFavourite: isFavourite)
    }
}
