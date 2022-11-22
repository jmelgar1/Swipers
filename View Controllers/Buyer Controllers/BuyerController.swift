//
//  BuyerController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/22/22.
//

import UIKit
import FirebaseFirestore
import Firebase

class BuyerController: UIViewController {
    
    var campus: String = ""
    
    let db = Firestore.firestore()
    
    let UserDefault: UserDefaults = UserDefaults.standard
    
    var firstNames = [String]()
    var lastNames = [String]()
    var phoneNumbers = [String]()
    var ratings = [String]()
    var swipePrices = [String]()
    var emails = [String]()
    var imageURLs = [String]()
    var userIds = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }

    @IBAction func theCommonsButtonPressed(_ sender: Any)
    {
        self.view.isUserInteractionEnabled = false
        
        campus = "Kennesaw"
        
        getCurrentSellerData()
            
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.performSegue(withIdentifier: "BuyerSearchSegue", sender: self)
            
            self.view.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func stingersButtonPressed(_ sender: Any)
    {
        self.view.isUserInteractionEnabled = false
        
        campus = "Marietta"
        
        getCurrentSellerData()
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.performSegue(withIdentifier: "BuyerSearchSegue", sender: self)
            
            self.view.isUserInteractionEnabled = true
        }
    }
    
    @objc func getCurrentSellerData(){
        db.collection("sellers\(campus)").getDocuments { (snapshot, error) in
            guard let snapshot = snapshot, error == nil else {
                Utilities.showError("There are no active buyers.")
                
                self.view.isUserInteractionEnabled = true
                
            return
            }
                snapshot.documents.forEach({ (documentSnapshot) in
                let documentData = documentSnapshot.data()
                
                //add firebase values to arrays
                self.firstNames.append((documentData["first_name"] as? String)!)
                self.lastNames.append((documentData["last_name"] as? String)!)
                self.phoneNumbers.append((documentData["phone_number"] as? String)!)
                self.ratings.append((documentData["rating"] as? String)!)
                self.swipePrices.append((documentData["swipe_price"] as? String)!)
                self.emails.append((documentData["email"] as? String)!)
                self.imageURLs.append(((documentData["image_url"]) as? String ?? "no_url"))
                self.userIds.append((documentData["userId"] as? String)!)
                    
                //assign arrays to user defaults
                self.UserDefault.set(self.firstNames, forKey: "firstNames")
                self.UserDefault.set(self.lastNames, forKey: "lastNames")
                self.UserDefault.set(self.phoneNumbers, forKey: "phoneNumbers")
                self.UserDefault.set(self.ratings, forKey: "ratings")
                self.UserDefault.set(self.swipePrices, forKey: "swipePrices")
                self.UserDefault.set(self.emails, forKey: "emails")
                self.UserDefault.set(self.imageURLs, forKey: "image_urls")
                self.UserDefault.set(self.userIds, forKey: "userIds")
            })
            //clearing arrays to prevent duplicates
            self.emptyArrays()
        }
    }
    
    func emptyArrays(){
        self.firstNames.removeAll()
        self.lastNames.removeAll()
        self.phoneNumbers.removeAll()
        self.ratings.removeAll()
        self.swipePrices.removeAll()
        self.emails.removeAll()
        self.imageURLs.removeAll()
        self.userIds.removeAll()
    }
    
    //Pass on the variable to next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SFSController
        
        vc.campus = campus
    }
}
