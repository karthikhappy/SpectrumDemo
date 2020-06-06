//
//  MemberCell.swift
//  SpectrumDemo
//
//  Created by nxgdev156 on 06/06/2020.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import UIKit

class MemberCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setMemberDetails(member: Member) {
        name.text =  member.name?.first ?? ""
        phone.text = member.phone ?? ""
        email.text = member.email ?? ""
        
        if let memberAge = member.age {
            age.text = "\(memberAge)"
        }
    }
}
