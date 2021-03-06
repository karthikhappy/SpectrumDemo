//
//  CompanyCell.swift
//  SpectrumDemo
//
//  Created by nxgdev156 on 06/06/2020.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import UIKit

protocol CompanyCellEditable: class {
    func markFavouriteCompany(isFavourite: Bool, index: Int)
}

class CompanyCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionInfo: UILabel!
    @IBOutlet weak var favouriteBtn: UIButton!
    weak public var delegate: CompanyCellEditable?
   
    private var cellIndex: Int!
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
    func setCompanyDetailsAt(index:Int, company: Company) {
        cellIndex = index
        name.text = company.company ?? ""
        descriptionInfo.text = company.about ?? ""
        website.text = company.website ?? ""
                
        favouriteBtn.isSelected = company.isFavorite ?? false
        
        guard let logoUrl = company.logo  else { return }
        guard let imagePath = company._id  else { return }

        ImageDownloader.downloadImage(logoUrl, imagePath: imagePath) {[weak self] (image, error) in
           if let logo = image {
               DispatchQueue.main.async {
                   self?.logoImageView.image = logo
               }
           }
        }
    }
    
    @IBAction func favouriteButtonAction(_ sender: Any) {
        favouriteBtn.isSelected = !favouriteBtn.isSelected
        delegate?.markFavouriteCompany(isFavourite: favouriteBtn.isSelected, index: cellIndex)
    }

}
