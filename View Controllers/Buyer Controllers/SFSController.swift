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
    
    //let db = Firestore.firestore()

    // var numOfDocuments: Int = 0
    
    var firstNamesList = UserDefaults.standard.stringArray(forKey: "firstNames")!
    var lastNamesList = UserDefaults.standard.stringArray(forKey: "lastNames")!
    var phoneNumbersList = UserDefaults.standard.stringArray(forKey: "phoneNumbers")!
    var ratingsList = UserDefaults.standard.stringArray(forKey: "ratings")!
    var swipePricesList = UserDefaults.standard.stringArray(forKey: "swipePrices")!
    
    let documentCount = UserDefaults.standard.integer(forKey: "documentCount")
    
    var diningHallType: String = ""
    var campusType: String = ""
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
        
        //get campus variable for retrieving user names for seller list
        
        //THIS DOES NOT UPDATE UNTIL KT IS TOO LATE IT IS ALWAYS ONE CLIKC BEHIND
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
        firstNamesList = []
        tableView.reloadData()
        print(" exited the scene eexited the scenenenenenen")
    }
    
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
}
