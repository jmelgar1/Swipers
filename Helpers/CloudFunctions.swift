//
//  CloudFunctions.swift
//  Swipers
//
//  Created by Josh Melgar on 3/23/22.
//

import Foundation
import Alamofire
import FirebaseAuth

class CloudFunctions {
    static func createStripeAccount(uid: String, completion: @escaping(String?, String?) -> Void) { //accountID, Error
        
        let parameters: [String: Any] = [:]
        
        let url = "https://us-east1-swipers-4bd9a.cloudfunctions.net/createConnectAccount"
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).responseJSON { reponse in
            
            switch reponse.result {
            case .success(let dict):
                print(dict)
                let successDict: [String: Any?] = dict as! [String: Any?]
                let body = successDict["body"] as! [String: Any?]
                let acctNum = body["success"] as! String
                completion(acctNum, nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    static func createAccountLink(accountID: String, completion: @escaping(String?, String?) -> Void) { //url, Error
        
        let parameters: [String:Any] = ["accountID": accountID]
        
        let url = "https://us-east1-swipers-4bd9a.cloudfunctions.net/createStripeAccountLink"
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).responseJSON { response in
            
            switch response.result {
            case .success(let dict):
                print(dict)
                let successDict: [String: Any?] = dict as! [String: Any?]
                let body = successDict["body"] as! [String: Any?]
                let link = body["success"] as! String
                completion(link, nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, error.localizedDescription)
            }
        }
    }
}
