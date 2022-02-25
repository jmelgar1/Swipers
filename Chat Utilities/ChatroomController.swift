//
//  ChatroomController.swift
//  Swipers
//
//  Created by Josh Melgar on 2/10/22.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import FirebaseFirestore
import FirebaseAuth
import SDWebImage

class ChatroomController: MessagesViewController {
    
    var currentUser: User = Auth.auth().currentUser!
    private var docRef: DocumentReference?
    var messages: [Message] = []
    
    let UserDefault: UserDefaults = UserDefaults.standard
    
    var otherUserName: String?
    var otherUserImgUrl: String?
    var otherUserUID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = otherUserName ?? "Chat"
        
        navigationItem.largeTitleDisplayMode = .never
        
        maintainPositionOnKeyboardFrameChanged = true
        scrollsToLastItemOnKeyboardBeginsEditing = true
        
        messageInputBar.inputTextView.tintColor = .systemBlue
        messageInputBar.sendButton.setTitleColor(.systemTeal, for: .normal)
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        getUserFullName()
        loadChat()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.becomeFirstResponder()
    }
    
    func getUserFullName(){
        
        let docRef = Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let firstName = (document.get("first_name") as? String)!
                let lastName = (document.get("last_name") as? String)!
                let fullName = "\(firstName) \(lastName)"
                
                self.UserDefault.set(fullName, forKey: "currentFullName")
            }
        }
    }
    
    func loadChat() {
        let db = Firestore.firestore().collection("Chats").whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "Not Found User 1")
        
        db.getDocuments { (chatQuerySnap, error) in
            if let error = error {
                Utilities.showError("Error: \(error)")
                return
            } else {
                guard let queryCount = chatQuerySnap?.documents.count else {
                    return
                }
                
                if queryCount == 0 {
                    self.createNewChat()
                }
                else if queryCount >= 1 {
                    for doc in chatQuerySnap!.documents {
                        let chat = Chat(dictionary: doc.data())
                        
                        //get chat which has user 2 id
                        if (chat?.users.contains(self.otherUserUID ?? "Id not found")) == true {
                            self.docRef = doc.reference
                            
                            //fetch thread collection
                            doc.reference.collection("thread").order(by: "created", descending: false).addSnapshotListener(includeMetadataChanges: true, listener: {(threadQuery, error) in
                                
                                if let error = error {
                                    Utilities.showError("Error: \(error)")
                                    return
                                } else {
                                    self.messages.removeAll()
                                    
                                    for message in threadQuery!.documents {
                                        let msg = Message(dictionary: message.data())
                                        self.messages.append(msg!)
                                        print("Data: \(msg?.content ?? "No message found")")
                                    }
                                    
                                    self.messagesCollectionView.reloadData()
                                    self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
                                }
                            })
                            return
                        }
                    }
                    
                    //this is a problem. It gets called too many times for some reason
                    //might need to use realtime database
                    self.createNewChat()
                } else {
                    print("Please dont print this ever")
                }
            }
        }
    }
    
    //this function is getting called too many times
    func createNewChat() {
        let users = [self.currentUser.uid, self.otherUserUID]
        let data: [String: Any] = [
            "users":users
        ]
        
        let db = Firestore.firestore().collection("Chats")
        db.addDocument(data: data) { (error) in
            if let error = error {
                Utilities.showError("Unable to create chat! \(error)")
                return
            } else {
                self.loadChat()
            }
        }
    }
    
    private func insertNewMessage(_ message: Message) {
        //add messages to array and reload
        messages.append(message)
        messagesCollectionView.reloadData()
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
        }
    }
    
    private func save(_ message: Message) {
        //prepare the data from firestore collection
        let data: [String: Any] = [
            "content": message.content,
            "created": message.created,
            "id": message.id,
            "senderID": message.senderID,
            "senderName": message.senderName
        ]
        
        docRef?.collection("thread").addDocument(data: data, completion: { (error) in
            if let error = error {
                Utilities.showError("Error sending message: \(error)")
                return
            }
            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
        })
    }
}

extension ChatroomController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        let fullName = UserDefaults.standard.string(forKey: "currentFullName")
        
        let message = Message(id: UUID().uuidString, content: text, created: Timestamp(), senderID: currentUser.uid, senderName: fullName!)
        
        //insert and save message
        insertNewMessage(message)
        save(message)
        
        //clear input field
        inputBar.inputTextView.text = ""
        
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
        
        //create conversation in database
        
    }
}

extension ChatroomController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    //MARK: MessageDataSource Functions
    
    func currentSender() -> SenderType {
        
        //instead of auth get full name from firebase
        return Sender(id: Auth.auth().currentUser!.uid, displayName: Auth.auth().currentUser?.displayName ?? "Name not found")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        if messages.count == 0 {
            print("There are no messages")
            return 0
        } else {
            return messages.count
        }
    }
    
    //MARK: MessageLayoutDelegate Functions
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    //MARK: MessageDisplayDelegate Functions
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .blue: .lightGray
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        if message.sender.senderId == currentUser.uid {
            SDWebImageManager.shared.loadImage(with: currentUser.photoURL, options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                
                avatarView.image = image
            }
        } else {
            SDWebImageManager.shared.loadImage(with: URL(string: otherUserImgUrl!), options: .highPriority, progress: nil) { ( image, data, error, cacheType, isFinished, imageUrl) in
                avatarView.image = image
            }
        }
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
        return .bubbleTail(corner, .curved)
    }
}
