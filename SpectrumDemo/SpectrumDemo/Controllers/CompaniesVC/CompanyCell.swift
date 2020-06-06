//
//  CompanyCell.swift
//  SpectrumDemo
//
//  Created by nxgdev156 on 06/06/2020.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionInfo: UILabel!
    
    lazy var serviceManger: ServiceManager = {
        return ServiceManager()
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        logoImageView.image = nil
        
        // set circle radius for company logo
        let radius = logoImageView.frame.width / 2
        logoImageView.layer.cornerRadius = radius
        logoImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    /// displaying comany name, logo, website and company description details
    /// Parameters:
    /// company - object which conatins name, logo, website and company description details
    func setCompanyDetails(company: Company) {
        name.text = company.company ?? ""
        descriptionInfo.text = company.about ?? ""
        website.text = company.website ?? ""
        guard let logoUrl = company.logo  else { return }
        serviceManger.downloadImage(logoUrl) { [weak self] (data, error) in
            if let imageData = data {
                DispatchQueue.main.async {
                    self?.logoImageView.image = UIImage(data: imageData)
                }
            }
        }
    }
}
