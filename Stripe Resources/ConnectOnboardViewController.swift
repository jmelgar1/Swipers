//
//  ConnectOnboardViewController.swift
//  Swipers
//
//  Created by Josh Melgar on 3/10/22.
//

import UIKit
import SafariServices
import SwiftUI

struct ConnectOnboardViewControllerView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ConnectOnboardViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "ConnectOnboardViewControllerView") as! ConnectOnboardViewController
        return vc
    }
    func updateUIViewController(_ uiViewController: ConnectOnboardViewController, context: Context) {
    }
    
    typealias UIViewControllerType = ConnectOnboardViewController
}

class ConnectOnboardViewController: UIViewController {
    
    @IBOutlet weak var payWithStripe: UIButton!
    
    // Set to the URL of your backend server
    let BackendAPIBaseURL: String = "https://swipers-4bd9a.firebaseapp.com/"
    //maybe https://swipers-4bd9a.web.app

    // ...

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonPressed(_ sender: Any) {
        didSelectConnectWithStripe()
    }
    
    func didSelectConnectWithStripe() {
        print("test 0")
        if let url = URL(string: BackendAPIBaseURL)?.appendingPathComponent("onboard-user") {
            
            print("test 1")
          var request = URLRequest(url: url)
            print("test 2")
          request.httpMethod = "POST"
            print("test 3")
          let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
              print("test 4")
              guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                  let accountURLString = json["url"] as? String,
                  let accountURL = URL(string: accountURLString) else {
                      print("error test")
                      // handle error
                      return
              }

              let safariViewController = SFSafariViewController(url: accountURL)
              safariViewController.delegate = self

              DispatchQueue.main.async {
                  self.present(safariViewController, animated: true, completion: nil)
              }
          }
        }
    }

    // ...
}

extension ConnectOnboardViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        // the user may have closed the SFSafariViewController instance before a redirect
        // occurred. Sync with your backend to confirm the correct state
    }
}
