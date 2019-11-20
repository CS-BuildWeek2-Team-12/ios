//
//  Status.swift
//  TreasureHunt
//
//  Created by Kobe McKee on 11/20/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import Foundation

struct Status: Codable {
    
    
    var name: String?
    var cooldown: Double?
    var encumbrance: Int?
    var strength: Int?
    var speed: Int?
    var gold: Int?
    var bodywear: String?
    var footwear: String?
    var inventory: [String]?
    var status: [String]?
    var errors: [String]?
    var messages: [String]?
    
    
    
}
