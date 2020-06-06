//
//  SearchView.swift
//  SpectrumDemo
//
//  Created by nxgdev156 on 06/06/2020.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import Foundation
import UIKit

protocol SearchViewAnimateble : class { }

extension SearchViewAnimateble where Self: UIViewController {

func showSearchBar(searchBar : UISearchBar) {
    searchBar.alpha = 0
    navigationItem.titleView = searchBar

    UIView.animate(withDuration: 0.7, animations: {
        searchBar.alpha = 1
    }, completion: { finished in
        searchBar.becomeFirstResponder()
    })
}

func hideSearchBar( searchBar : UISearchBar, titleView : UIView?) {
    titleView?.alpha = 0
    UIView.animate(withDuration: 0.3, animations: {
        self.navigationItem.titleView = titleView
        titleView?.alpha = 1
    }, completion: { finished in

    })
 }
}
