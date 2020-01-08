//
//  CoinHistoryResponse.swift
//  CryptoBuzz
//
//  Created by Ajay Choudhary on 31/12/19.
//  Copyright © 2019 Ajay Choudhary. All rights reserved.
//

import Foundation

struct CoinHistoryResponse: Codable {
    let status: String
    let data: HistoryData
}
