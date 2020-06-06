//
//  ActivityIndcator.swift
//  SpectrumDemo
//
//  Created by nxgdev156 on 06/06/2020.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import UIKit

class ActivityView: UIView {

     func showIndicator() {
        self.frame = UIApplication.shared.windows[0].frame
        self.backgroundColor = UIColor.black
        self.alpha = 0.8
        UIApplication.shared.windows[0].addSubview(self)
        
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.center
        self.addSubview(activityView)
        activityView.startAnimating()

    }
    
     func hideIndicator() {
        self.removeFromSuperview()
    }
}
