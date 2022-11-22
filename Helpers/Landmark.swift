//
//  Landmark.swift
//  Swipers
//
//  Created by Josh Melgar on 11/9/22.
//

import Foundation

struct Landmark: Hashable, Codable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
}
