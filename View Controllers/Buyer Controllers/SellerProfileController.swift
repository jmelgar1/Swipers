//
//  SellerProfileController.swift
//  Swipers
//
//  Created by Josh Melgar on 2/10/22.
//

import UIKit
import SwiftUI

class SellerProfileController: UIViewController {
    
    @IBOutlet weak var fullNameField: UILabel!
    @IBOutlet weak var ratingField: UITextField!
    @IBOutlet weak var swipePriceField: UITextField!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var container: UIView!
    
    var firstName: String = ""
    var fullName: String = ""
    var rating: String = ""
    var swipePrice: String = ""
    var userId: String = ""
    var imageUrl: String = ""
    
    static let instance = SellerProfileController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgrounds()
        
        fullNameField.text = fullName
        ratingField.text = rating
        swipePriceField.text = swipePrice
        buyButton.setTitle("Buy From \(firstName)", for: .normal)
    }
    
    override func viewWillLayoutSubviews() {
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width/2
        self.profilePicture.clipsToBounds = true
    }
    
    @IBAction func buyButtonPressed(_ sender: Any) {
        
        guard let sellerFullName = fullNameField.text else { return }
        
        let TitleRowData = TitleRowData()
        TitleRowData.sellerFullName = sellerFullName
                
        let childView = UIHostingController(rootView: ContentView().environmentObject(TitleRowData))
        childView.view.frame = container.bounds
        container.addSubview(childView.view)
        childView.didMove(toParent: self)
        
        UserDefaults.standard.set(userId, forKey: "otherUserId")
        UserDefaults.standard.set(imageUrl, forKey: "otherUserImageUrl")
    }
    
    func setBackgrounds(){
        ratingField.background = UIImage(named: "priceField.png")
        swipePriceField.background = UIImage(named: "priceField.png")
    }
}
