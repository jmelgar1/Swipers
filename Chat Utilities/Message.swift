//
//  MessageNew.swift
//  Swipers
//
//  Created by Josh Melgar on 3/2/22.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}
