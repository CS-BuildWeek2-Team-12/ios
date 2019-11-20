//
//  Room.swift
//  TreasureHunt
//
//  Created by Kobe McKee on 11/19/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import Foundation

struct Room: Codable {
    
    var id: Int
    var title: String
    var description: String
    var coordinates: String
    var elevation: Int?
    var terrain: String?
    var players: [String]?
    var items: [String]?
    var exits: [String]
    var cooldown: Double
    var errors: [String]?
    var messages: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id = "room_id"
        case title
        case description
        case coordinates
        case elevation
        case terrain
        case players
        case items
        case exits
        case cooldown
        case errors
        case messages
    }
    
}
