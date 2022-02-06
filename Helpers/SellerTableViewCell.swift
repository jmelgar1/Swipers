//
//  TableViewCell.swift
//  Swipers
//
//  Created by Josh Melgar on 2/6/22.
//

import UIKit

class SellerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var swipePrice: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var ratingStar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
