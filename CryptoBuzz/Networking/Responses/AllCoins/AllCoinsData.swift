//
//  AllCoinsData.swift
//  CryptoBuzz
//
//  Created by Ajay Choudhary on 12/12/19.
//  Copyright © 2019 Ajay Choudhary. All rights reserved.
//

import Foundation

struct AllCoinsData: Codable {
    let stats: AllCoinsStats
    let coins: [Coin]
}
