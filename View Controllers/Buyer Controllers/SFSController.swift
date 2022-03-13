//
//  LFSKennesawController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/28/22.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseFirestore
import Kingfisher

class SFSController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var firstNamesList = UserDefaults.standard.stringArray(forKey: "firstNames")!
    var lastNamesList = UserDefaults.standard.stringArray(forKey: "lastNames")!
    var phoneNumbersList = UserDefaults.standard.stringArray(forKey: "phoneNumbers")!
    var ratingsList = UserDefaults.standard.stringArray(forKey: "ratings")!
    var swipePricesList = UserDefaults.standard.stringArray(forKey: "swipePrices")!
    var emailsList = UserDefaults.standard.stringArray(forKey: "emails")!
    var imageURLsList = UserDefaults.standard.stringArray(forKey: "image_urls")!
    var userIdsList = UserDefaults.standard.stringArray(forKey: "userIds")!
    
    var diningHallType: String = ""
    var campus: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (campus == "Kennesaw") {
            self.title = "The Commons"
        } else {
            self.title = "Stingers"
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //Set number of rows in the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstNamesList.count
    }
    
    //fill in all new/existing cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SellerTableViewCell
        
        cell.swipePrice.background = UIImage(named: "priceField.png")
        cell.rating.background = UIImage(named: "priceField.png")
        cell.fullName.text = "\(firstNamesList[indexPath.row]) \(lastNamesList[indexPath.row])"
        cell.rating.text = ratingsList[indexPath.row]
        cell.swipePrice.text = "$" + swipePricesList[indexPath.row]
        
        DatabaseManager.getUserAvatarFromURLString(imageURL: imageURLsList[indexPath.row]) { (image) in
            cell.profilePicture.image = image
        }
        
        return cell
    }
    
    //check which cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        UserDefaults.standard.set(indexPath.row, forKey: "cellNum")
        
        self.performSegue(withIdentifier: "SellerProfileSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cellNum = UserDefaults.standard.integer(forKey: "cellNum")
        
        if segue.identifier == "SellerProfileSegue" {
            let vc = segue.destination as! SellerProfileController
            
            vc.firstName = firstNamesList[cellNum]
            vc.fullName = "\(firstNamesList[cellNum]) \(lastNamesList[cellNum])"
            vc.rating = ratingsList[cellNum]
            vc.swipePrice = "$\(swipePricesList[cellNum])"
            vc.userId = userIdsList[cellNum]
            vc.imageUrl = imageURLsList[cellNum]
            
            //convert urlstrings to images
            DatabaseManager.getUserAvatarFromURLString(imageURL: imageURLsList[cellNum]) { (image) in
                vc.profilePicture.image = image
                
                //need to cache other user profile pictures
                //vc.profilePicture.kf.setImage(with: image)
            }
        }
    }
}
