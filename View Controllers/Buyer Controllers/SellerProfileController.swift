//
//  SellerProfileController.swift
//  Swipers
//
//  Created by Josh Melgar on 2/10/22.
//

import UIKit

class SellerProfileController: UIViewController {
    
    @IBOutlet weak var fullNameField: UILabel!
    @IBOutlet weak var ratingField: UITextField!
    @IBOutlet weak var swipePriceField: UITextField!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    
    var firstName: String = ""
    var fullName: String = ""
    var rating: String = ""
    var swipePrice: String = ""

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
        
        //calls chatroom view controller when pressed
        NotificationCenter.default.post(name: Notification.Name.Chatroom.CallChatroomMethod, object: nil)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func setBackgrounds(){
        ratingField.background = UIImage(named: "priceField.png")
        swipePriceField.background = UIImage(named: "priceField.png")
        }
    }

extension Notification.Name {
    struct Chatroom {
        static let CallChatroomMethod = Notification.Name("CallChatRoomMethod")
    }
}

