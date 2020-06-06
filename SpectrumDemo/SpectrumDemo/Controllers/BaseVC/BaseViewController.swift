//
//  BaseViewController.swift
//  SpectrumDemo
//
//  Created by nxgdev156 on 06/06/2020.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UISearchBarDelegate, SearchViewAnimateble {

    private var searchBar = UISearchBar()
    private var logoImageView   : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black

        addRightBarButtonItems()
        
        // Add title Label View
        let logoImage = UIImage(named: "log-nav-title")!
        logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: logoImage.size.width, height: logoImage.size.height))
        logoImageView.image = logoImage
        navigationItem.titleView = logoImageView

        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBar.Style.minimal
    }
   
    func addRightBarButtonItems() {
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonPressed))
        search.tintColor = .black
        
        let filterView = UIImageView(image: UIImage.init(named: "filter_icon"))
        filterView.isUserInteractionEnabled = false
        let filter = UIBarButtonItem(customView: filterView)
        filter.target = self
        filter.isEnabled = true
        filter.action = #selector(self.filterButtonPressed)
        
        navigationItem.rightBarButtonItems = [search, filter]
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
    }

    @IBAction func cancelButtonPressed(sender: AnyObject) {
        addRightBarButtonItems()
        hideSearchBar( searchBar: searchBar, titleView : logoImageView)
    }

    //MARK: UISearchBarDelegate
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = nil
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }

}
 
