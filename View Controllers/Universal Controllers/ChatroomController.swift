//
//  ChatroomController.swift
//  Swipers
//
//  Created by Josh Melgar on 2/10/22.
//

import UIKit
import MessageKit

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

class ChatroomController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    var sellerFirstName: String = ""
    var sellerFullName: String = ""
    var sellerPhoneNumber: String = ""
    
    var buyerfirstName: String = ""
    var buyerFullName: String = ""
    var buyerPhoneNumber: String = ""
    
    //current user: get current firebase uid and get first and last name
    let currentUser = Sender(senderId: "self", displayName: "My user")
    
    //other user is whatever user the current user clicked on in seller list
    let otherUser = Sender(senderId: "other", displayName: "Other user")
    
    var messages = [MessageType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date().addingTimeInterval(-86400), kind: .text("test test")))
        
        messages.append(Message(sender: otherUser, messageId: "2", sentDate: Date().addingTimeInterval(-86400), kind: .text("test test 2")))
            */
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }

    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
}
