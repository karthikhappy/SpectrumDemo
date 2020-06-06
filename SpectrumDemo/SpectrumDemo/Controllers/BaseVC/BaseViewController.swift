//
//  BaseViewController.swift
//  SpectrumDemo
//
//  Created by nxgdev156 on 06/06/2020.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import UIKit
import DropDown

class BaseViewController: UIViewController, UISearchBarDelegate, SearchViewAnimateble {

    private var logoImageView: UIImageView!
    
    private lazy var searchBar: UISearchBar = {
        return UISearchBar()
    }()

    private lazy var dropDown: DropDown = {
        return DropDown()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black

        addSortAndSearchButtonItems()
        
        addNavigationTitleView()
        
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBar.Style.minimal
    }

    //MARK: UISearchBarDelegate
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = nil
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }

     //MARK: DropDown Selection
    public func dropDowndidSelectAtIndex(index: Int, item: String)  {
    
    }
    
    func dropDownDataSource() -> Array<String>? {
       dropDown.dataSource = CompanyFilters.allCases.map { $0.rawValue }
        return nil
    }
}
 
//MARK: Navigationbar Items
extension BaseViewController {
    
    func addNavigationTitleView() {
        let logoImage = UIImage(named: "log-nav-title")!
        logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: logoImage.size.width, height: logoImage.size.height))
        logoImageView.image = logoImage
        navigationItem.titleView = logoImageView
    }
    
     func addSortAndSearchButtonItems() {
         let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonPressed))
         search.tintColor = .black

         
         let sortButton   = UIButton(type: .custom) as UIButton
         sortButton.setImage(UIImage.init(named: "filter_icon"), for: .normal)
         sortButton.addTarget(self, action: #selector(self.filterButtonPressed), for:.touchUpInside)
         let sort = UIBarButtonItem(customView: sortButton)
         let widthConstraint = sortButton.widthAnchor.constraint(equalToConstant: 22)
         let heightConstraint = sortButton.heightAnchor.constraint(equalToConstant: 22)
         heightConstraint.isActive = true
         widthConstraint.isActive = true

         navigationItem.rightBarButtonItems = [search, sort]
     }
     
     func addCancelSearchButtonItem() {
         let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
         cancel.tintColor = .black
         navigationItem.rightBarButtonItem = cancel
     }
     
     func addleftBarButtonItem() {
         let logoView = UIImageView(image: UIImage.init(named: "spectrum_logo"))
         let leftBarItem = UIBarButtonItem(customView: logoView)
         navigationItem.leftBarButtonItem = leftBarItem
     }

     @IBAction func searchButtonPressed(sender: AnyObject) {
         navigationItem.rightBarButtonItems = nil
         addCancelSearchButtonItem()
         showSearchBar(searchBar: searchBar)
      
     }
     
     @objc func filterButtonPressed(sender: UIBarButtonItem) {
         showDropDownfrom(view: sender)
     }

     @IBAction func cancelButtonPressed(sender: AnyObject) {
         addSortAndSearchButtonItems()
         hideSearchBar( searchBar: searchBar, titleView : logoImageView)
     }

    private func showDropDownfrom(view: UIBarButtonItem) {
       
        guard let dropDownItems = dropDownDataSource() else { return }
        dropDown.dataSource = dropDownItems
        dropDown.anchorView = view
        dropDown.bottomOffset = CGPoint(x: -30, y: 30)
        dropDown.arrowIndicationX =  32
        dropDown.cornerRadius = 5.0
        dropDown.direction = .bottom
        
        dropDown.show()
        
        // Action triggered on selection
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.dropDowndidSelectAtIndex(index: index, item: item)
        }
    }
}
