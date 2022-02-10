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
        
        if (campus == "Kennesaw") {
            diningHallType = "The Commons"
        } else {
            diningHallType = "Stingers"
        }
        
        self.title = diningHallType
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //clear the tableview when user clicks back button
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tableView.dataSource = nil
        tableView.reloadData()
    }
    
    //Set number of rows in the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstNamesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SellerTableViewCell
        
        cell.swipePrice.background = UIImage(named: "priceField.png")
        cell.rating.background = UIImage(named: "priceField.png")
        
        cell.fullName.text = firstNamesList[indexPath.row]
        cell.rating.text = ratingsList[indexPath.row]
        cell.swipePrice.text = "$" + swipePricesList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        self.performSegue(withIdentifier: "SellerProfileSegue", sender: self)
    }
}
