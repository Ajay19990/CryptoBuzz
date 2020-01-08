//
//  File.swift
//  CryptoBuzz
//
//  Created by Ajay Choudhary on 31/12/19.
//  Copyright © 2019 Ajay Choudhary. All rights reserved.
//

import UIKit

struct HistoryData: Codable {
    let change: Double
    let history: [History]
}
