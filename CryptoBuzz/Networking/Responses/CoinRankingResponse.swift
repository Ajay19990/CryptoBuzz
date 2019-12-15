//
//  CoinRankingResponse.swift
//  CryptoBuzz
//
//  Created by Ajay Choudhary on 15/12/19.
//  Copyright © 2019 Ajay Choudhary. All rights reserved.
//

import Foundation

struct CoinRankingResponse: Codable {
    let status: String
    let type: String
    let message: String
}

extension CoinRankingResponse: Error {
    var localizedDescription: String {
        return message
    }
}
