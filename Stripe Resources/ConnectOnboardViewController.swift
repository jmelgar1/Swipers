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

let BackendAPIBaseURL: String = "https://swipers-4bd9a.web.app"

class ConnectOnboardViewController: UIViewController {
    
    @IBOutlet weak var payWithStripe: UIButton!

    // ...

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonPressed(_ sender: Any) {
        didSelectConnectWithStripe()
    }
    
    func didSelectConnectWithStripe() {
        if let url = URL(string: BackendAPIBaseURL)?.appendingPathComponent("onboard-user") {
          var request = URLRequest(url: url)
          request.httpMethod = "POST"
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
              guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                  let accountURLString = json["url"] as? String,
                  let accountURL = URL(string: accountURLString) else {
                      //error
                      print(error)
                      return
              }

              let safariViewController = SFSafariViewController(url: accountURL)
              safariViewController.delegate = self

              DispatchQueue.main.async {
                  self.present(safariViewController, animated: true, completion: nil)
              }
          }
        task.resume()
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
