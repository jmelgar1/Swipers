//
//  Extensions.swift
//  Swipers
//
//  Created by Josh Melgar on 2/23/22.
//

import UIKit

//Remove seller from list method
extension Notification.Name {
    struct Action {
        static let CallRemoveMethod = Notification.Name("CallRemoveMethod")
    }
}

//Go to chatroom method
extension Notification.Name {
    struct Chatroom {
        static let CallChatroomMethod = Notification.Name("CallChatRoomMethod")
    }
}

//Go to tab bar controller
extension Notification.Name {
    struct TabBar {
        static let CallTabBarSegue = Notification.Name("CallTabBarSegue")
    }
}
