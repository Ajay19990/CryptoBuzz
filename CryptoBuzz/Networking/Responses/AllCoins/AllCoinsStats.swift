//
//  AllCoinsStats.swift
//  CryptoBuzz
//
//  Created by Ajay Choudhary on 12/12/19.
//  Copyright © 2019 Ajay Choudhary. All rights reserved.
//

import Foundation

struct AllCoinsStats: Codable {
    let total: Int
    let offset: Int
    let limit: Int
    let order: String
    let base: String
}
