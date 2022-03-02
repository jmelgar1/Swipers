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

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
