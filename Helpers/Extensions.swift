//
//  Extensions.swift
//  Swipers
//
//  Created by Josh Melgar on 2/23/22.
//

import UIKit
import SwiftUI

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

//Go to stripe controller
extension Notification.Name {
    struct Stripe {
        static let CallStripeController = Notification.Name("CallStripeController")
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
