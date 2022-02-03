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
import ProgressHUD

class SignUpViewController2: UIViewController {
    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var button: UIButton?
    
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var password: String = ""
    var verificationId: String = ""
    
    let userDefault = UserDefaults.standard
    
    //camera talon card picture function here
    
    @IBAction func submitButtonPressed(_ sender: Any)
    {
                //send SMS code to user
                PhoneAuthProvider.provider().verifyPhoneNumber("+1\(phoneNumber)", uiDelegate: nil) { verificationId, error in
                    if error == nil {
                        
                        print(verificationId!)
                        guard let verifyId = verificationId else { return }
                        self.userDefault.set(verifyId, forKey: "verificationId")
                        self.userDefault.synchronize()
                        
                    } else {
                        Utilities.showError("Unable to get secret verification code from firebase")
                    }
                }
                
                //switch to sms confirm view controller
                self.performSegue(withIdentifier: "VerifySegue", sender: self)
        }
    
    //Waits for user to click take a photo
    @IBAction func didTapTakePhoto(){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Pass on variables to next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SMSVerifyViewController
        vc.firstName = firstName
        vc.lastName = lastName
        vc.email = email
        vc.phoneNumber = phoneNumber
        vc.password = password
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
