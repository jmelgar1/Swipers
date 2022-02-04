//
//  LFSKennesawController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/28/22.
//

import UIKit
import Firebase
import FirebaseFirestore

class SFSController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    var firstNames = [String]()
    var lastNames = [String]()
    var phoneNumbers = [String]()
    var ratings = [Double]()
    var swipePrices = [Double]()
    
    //get first & last names from firebase and put into array for printing to tableview
    
    //get phone numbers as well to connect users when a match is made
    
    var campusType: String = ""
    var campus: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = campusType
        
        //tableView.delegate = self
        //tableView.dataSource = self
        
        //get campus variable for retrieving user names for seller list
        if(campusType == "The Commons"){
            campus = "Kennesaw"
        } else {
            campus = "Marietta"
        }
        
        getNames()
    }
    
    func getNames(){
        db.collection("sellers\(campus)").getDocuments { (snapshot, error) in
            guard let snapshot = snapshot, error == nil else {
                Utilities.showError("There are no active buyers.")
            return
            }
            print("Number of documents: \(snapshot.documents.count ?? -1)")
            snapshot.documents.forEach({ (documentSnapshot) in
            let documentData = documentSnapshot.data()
            self.firstNames.append((documentData["first_name"] as? String)!)
            self.lastNames.append((documentData["last_name"] as? String)!)
            self.phoneNumbers.append((documentData["phone_number"] as? String)!)
            self.ratings.append((documentData["rating"] as? Double)!)
            self.swipePrices.append((documentData["swipe_price"] as? Double)!)
            })
        }
    }
/*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
 */
}
