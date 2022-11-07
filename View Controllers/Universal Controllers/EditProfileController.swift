//
//  EditProfileController.swift
//  Swipers
//
//  Created by Josh Melgar on 2/12/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class EditProfileController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private let storage = Storage.storage().reference()

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var editNameTextField: UITextField!
    @IBOutlet weak var editEmailTextField: UITextField!
    @IBOutlet weak var editPhoneNumberTextField: UITextField!
    @IBOutlet weak var editPasswordTextField: UITextField!
    

    @IBOutlet weak var venmoSwitch: UISwitch!
    @IBOutlet weak var applepaySwitch: UISwitch!
    @IBOutlet weak var cashappSwitch: UISwitch!
    @IBOutlet weak var zelleSwitch: UISwitch!
    @IBOutlet weak var paypalSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSwitches(switchType: venmoSwitch, paymethod:"venmo")
        setSwitches(switchType: applepaySwitch, paymethod:"apple_pay")
        setSwitches(switchType: cashappSwitch, paymethod:"cash_app")
        setSwitches(switchType: zelleSwitch, paymethod:"zelle")
        setSwitches(switchType: paypalSwitch, paymethod:"paypal")
        
        venmoSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        applepaySwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        cashappSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        zelleSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        paypalSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        
        loadAttributes()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGestureRecognizer)
        
        //will figure out how to show password later
        //take length of password from login and send it here
        
        //detect tap on textfield to go to new phone number confirmation
    }
    
    @objc func switchChanged(switchType: UISwitch){
        let value = switchType.isOn
        if(switchType == venmoSwitch){
            DatabaseManager.changePaymentMethod(paymentMethod:"venmo", newValue: value)
        } else if (switchType == applepaySwitch){
            DatabaseManager.changePaymentMethod(paymentMethod:"apple_pay", newValue: value)
        } else if (switchType == cashappSwitch){
            DatabaseManager.changePaymentMethod(paymentMethod:"cash_app", newValue: value)
        } else if (switchType == paypalSwitch){
            DatabaseManager.changePaymentMethod(paymentMethod:"paypal", newValue: value)
        } else if (switchType == zelleSwitch){
            DatabaseManager.changePaymentMethod(paymentMethod:"zelle", newValue: value)
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2
        self.profileImage.clipsToBounds = true
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true){
            //after completed
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            profileImage.image = image
            
            guard let imageData = image.pngData() else {
                return
            }
            
            //Store profile picture in database
            DatabaseManager.getEmail() { (email) in
                let userEmail = email
            
            //images/useruid to save image
                self.storage.child("profilePictures/\(userEmail).png").putData(imageData, metadata: nil) { _, error in
                guard error == nil else {
                    Utilities.showError("Failed to upload photos to database")
                    return
                }
                
                self.storage.child("profilePictures/\(userEmail).png").downloadURL(completion: { url, error in
                    guard let url = url, error == nil else {
                        return
                    }
                    
                    let urlString = url.absoluteString
                    print("Download URL: \(urlString)")
                    UserDefaults.standard.set(urlString, forKey: "url")
                    })
                }
            }
        }
        else
        {
            //error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadAttributes(){
        DatabaseManager.getUserAvatar(profileImage: profileImage)
        
        DatabaseManager.getFullName() { (fullName) in
            self.editNameTextField.placeholder = fullName
        }
        
        DatabaseManager.getEmail() { (email) in
            self.editEmailTextField.text = email
        }
        
        DatabaseManager.getPhoneNumber() { (phoneNumber) in
            self.editPhoneNumberTextField.text = phoneNumber
        }
    }
    
    func setSwitches(switchType: UISwitch, paymethod: String){
        DatabaseManager.checkForPaymentMethod(paymentMethod: paymethod) { enabled in
            if enabled {
                switchType.setOn(true, animated: false)
            } else {
                switchType.setOn(false, animated: false)
            }
        }
    }
}
