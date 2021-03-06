//
//  TableViewCell.swift
//  Swipers
//
//  Created by Josh Melgar on 2/6/22.
//

import UIKit

class SellerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var rating: UITextField!
    @IBOutlet weak var swipePrice: UITextField!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var ratingStar: UIImageView!
    
    override func layoutSubviews() {
        profilePicture.layer.cornerRadius = profilePicture.bounds.height/2
        profilePicture.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
