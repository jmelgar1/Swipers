//
//  MessagesManager.swift
//  Swipers
//
//  Created by Josh Melgar on 3/2/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class MessagesManager: ObservableObject {
    
    var otherUserId = UserDefaults.standard.string(forKey: "otherUserId")!
    var currentUserId = Auth.auth().currentUser!.uid
    var urlString: String = ""
    let db = Firestore.firestore()
    
    @Published private(set) var messages: [Message] = []
    @Published private(set) var lastMessageId = ""

    init() {
        getMessages()
    }
    
    func getMessages() {
        let chatDocument = "\(currentUserId) & \(otherUserId) Chat"
        
        //current user and other user uid document name, find where name equals and get document name
        db.collection(chatDocument).addSnapshotListener { QuerySnapshot, error in
            guard let documents = QuerySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            //Similar to map but only returns non-nil values
            self.messages = documents.compactMap { document -> Message? in
                do {
                    return try document.data(as: Message.self)
                } catch {
                    print("Error decoding document into Message: \(error)")
                    return nil
                }
            }
            
            self.messages.sort { $0.timestamp < $1.timestamp }
            
            if let id = self.messages.last?.id {
                self.lastMessageId = id
            }
        }
    }
    
    func sendMessage(text: String) {
        let chatDocument = "\(currentUserId) & \(otherUserId) Chat"
        
        do {
            let newMessage = Message(id: "\(UUID())", text: text, received: false, timestamp: Date())
            
            try db.collection(chatDocument).document().setData(from: newMessage)
        } catch {
            print("Error adding message to Firestore: \(error)")
        }
    }
}

class MessagesManagerData: ObservableObject {
    @Published var otherUserId: String  = ""
}
