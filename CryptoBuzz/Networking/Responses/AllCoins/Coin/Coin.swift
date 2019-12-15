//
//  Coin.swift
//  CryptoBuzz
//
//  Created by Ajay Choudhary on 12/12/19.
//  Copyright © 2019 Ajay Choudhary. All rights reserved.
//

import Foundation

struct Coin: Codable {
    let id: Int
    let slug: String
    let symbol: String
    let name: String
    let description: String?
    let color: String?
    let iconType: String
    let iconUrl: String
    let websiteUrl: String?
    let socials: [CoinSocials]
    let confirmedSupply: Bool
    let type: String
    let volume: Int
    let marketCap: Int
    let price: String
    let circulatingSupply: Double
    let totalSupply: Double
    let firstSeen: Int
    let change: Double
    let rank: Int
    let numberOfMarkets: Int
    let numberOfExchanges: Int
    let history: [String]
    let allTimeHigh: CoinAllTimeHigh
    let penalty: Bool
}
