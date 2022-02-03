//
//  LFSKennesawController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/28/22.
//

import UIKit

class SFSController: UIViewController {
    
    //@IBOutlet var tableView: UITableView!
    
    //get first & last names from firebase and put into array for printing to tableview
    
    //get phone numbers as well to connect users when a match is made
    
    var campusType: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = campusType
        
        //tableView.delegate = self
        //tableView.dataSource = self
    }
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //this is an error
    }
     */
}
