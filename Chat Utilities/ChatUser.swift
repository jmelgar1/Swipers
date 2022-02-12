//
//  ChatUser.swift
//  Swipers
//
//  Created by Josh Melgar on 2/12/22.
//

import Foundation
import MessageKit

struct ChatUser: SenderType, Equatable {
    var senderId: String
    var displayName: String
}
