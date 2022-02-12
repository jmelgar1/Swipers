//
//  DatabaseManager.swift
//  Swipers
//
//  Created by Josh Melgar on 2/11/22.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
}

struct ChatroomUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    let phoneNumber: String
}
