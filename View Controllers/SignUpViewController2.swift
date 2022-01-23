//
//  SignUpViewController2.swift
//  Swipers
//
//  Created by Josh Melgar on 1/21/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage
import FirebaseCore
import FirebaseDatabase
import FirebaseFirestore

class SignUpViewController2: UIViewController {
    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var button: UIButton?
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var password: String = ""
    
    var delegate: ErrorProtocol?
    
    //camera talon card picture function here
    
    //show error message if for some reason there is an error
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }

    @IBAction func submitButtonPressed(_ sender: Any)
    {
        
        //Create the user
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            
            //Check for errors
            if err != nil {
                
                self.showError("Error creating user")
                //There was an issue creating the user
            }
            else {
                //User can be created, store the data
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["first_name":self.firstName,"last_name":self.lastName, "uid": result!.user.uid]) { (error) in
                    
                    if error != nil {
                        self.delegate?.showError("Error saving user data")
                    }
                }
                
                self.performSegue(withIdentifier: "SignUpCompletedShow", sender: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        elementsSetup()
    }
    
    func elementsSetup(){
        errorLabel.alpha = 0
    }
    
    @IBAction func didTapTakePhoto(){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension SignUpViewController2 : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else
        {
            return
        }
        imageView?.image = image
    }
}
