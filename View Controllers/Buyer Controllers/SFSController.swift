//
//  LFSKennesawController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/28/22.
//

import UIKit
import Firebase
import FirebaseFirestore

class SFSController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var firstNamesList = UserDefaults.standard.stringArray(forKey: "firstNames")!
    var lastNamesList = UserDefaults.standard.stringArray(forKey: "lastNames")!
    var phoneNumbersList = UserDefaults.standard.stringArray(forKey: "phoneNumbers")!
    var ratingsList = UserDefaults.standard.stringArray(forKey: "ratings")!
    var swipePricesList = UserDefaults.standard.stringArray(forKey: "swipePrices")!
    
    var diningHallType: String = ""
    var campus: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToChatroom), name: Notification.Name.Chatroom.CallChatroomMethod, object: nil)
        
        if (campus == "Kennesaw") {
            diningHallType = "The Commons"
        } else {
            diningHallType = "Stingers"
        }
        
        self.title = diningHallType
        
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
        
        return cell
    }
    
    //check which cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        UserDefaults.standard.set(indexPath.row, forKey: "cellNum")
        
        self.performSegue(withIdentifier: "SellerProfileSegue", sender: self)
    }
    
    @objc func goToChatroom(){
        self.performSegue(withIdentifier: "ChatroomSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SellerProfileSegue" {
            let vc = segue.destination as! SellerProfileController
            
            var cellNum = UserDefaults.standard.integer(forKey: "cellNum")
            
            vc.firstName = firstNamesList[cellNum]
            vc.fullName = "\(firstNamesList[cellNum]) \(lastNamesList[cellNum])"
            vc.rating = ratingsList[cellNum]
            vc.swipePrice = "$\(swipePricesList[cellNum])"
            
        } else if segue.identifier == "ChatroomSegue" {
            let vc = segue.destination as! ChatroomController
        }
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}
