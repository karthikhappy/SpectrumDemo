//
//  MemberCell.swift
//  SpectrumDemo
//
//  Created by nxgdev156 on 06/06/2020.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import UIKit

protocol MemberCellEditable: class {
    func markFavouriteMember(isFavourite: Bool, index: Int)
}

class MemberCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var favouriteBtn: UIButton!
     
    weak public var delegate: MemberCellEditable?
    private var cellIndex: Int!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setMemberDetailsAt(index: Int, member: Member) {
        cellIndex = index
        name.text =  member.name?.first ?? ""
        phone.text = member.phone ?? ""
        email.text = member.email ?? ""
        
        favouriteBtn.isSelected = member.isFavorite ?? false
        
        if let memberAge = member.age {
            age.text = "\(memberAge)"
        }
    }
    
    @IBAction func favouriteButtonAction(_ sender: Any) {
        favouriteBtn.isSelected = !favouriteBtn.isSelected
        delegate?.markFavouriteMember(isFavourite: favouriteBtn.isSelected, index: cellIndex)
    }

}
