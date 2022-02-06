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
    
    let db = Firestore.firestore()
    
    let UserDefault: UserDefaults = UserDefaults.standard
    
    var firstNames = [String]()
    var lastNames = [String]()
    var phoneNumbers = [String]()
    var ratings = [String]()
    var swipePrices = [String]()
    
    let firstNamesList = UserDefaults.standard.stringArray(forKey: "firstNames")!
    let lastNamesList = UserDefaults.standard.stringArray(forKey: "lastNames")!
    let phoneNumbersList = UserDefaults.standard.stringArray(forKey: "phoneNumbers")!
    let ratingsList = UserDefaults.standard.stringArray(forKey: "ratings")!
    let swipePricesList = UserDefaults.standard.stringArray(forKey: "swipePrices")!
    
    var campusType: String = ""
    var campus: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = campusType
        
        let nib = UINib(nibName: "SellerTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SellerTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        //get campus variable for retrieving user names for seller list
        if(campusType == "The Commons"){
            campus = "Kennesaw"
        } else {
            campus = "Marietta"
        }
        
        //get current user document data
        getCurrentSellerData()
    }
    
    func getCurrentSellerData(){
        db.collection("sellers\(campus)").getDocuments { (snapshot, error) in
            guard let snapshot = snapshot, error == nil else {
                Utilities.showError("There are no active buyers.")
            return
            }
                print("Number of documents: \(snapshot.documents.count ?? -1)")
                snapshot.documents.forEach({ (documentSnapshot) in
                let documentData = documentSnapshot.data()
                    
                //add firebase values to arrays
                self.firstNames.append((documentData["first_name"] as? String)!)
                self.lastNames.append((documentData["last_name"] as? String)!)
                self.phoneNumbers.append((documentData["phone_number"] as? String)!)
                self.ratings.append((documentData["rating"] as? String)!)
                self.swipePrices.append((documentData["swipe_price"] as? String)!)
                    
                //assign arrays to user defaults
                self.UserDefault.set(self.firstNames, forKey: "firstNames")
                self.UserDefault.set(self.lastNames, forKey: "lastNames")
                self.UserDefault.set(self.phoneNumbers, forKey: "phoneNumbers")
                self.UserDefault.set(self.ratings, forKey: "ratings")
                self.UserDefault.set(self.swipePrices, forKey: "swipePrices")
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstNamesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SellerTableViewCell", for: indexPath) as! SellerTableViewCell
        
        cell.fullName.text = firstNamesList[indexPath.row]
        cell.rating.text = ratingsList[indexPath.row]
        cell.swipePrice.text = swipePricesList[indexPath.row]
        return cell
    }
}
