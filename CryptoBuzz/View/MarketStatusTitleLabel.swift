//
//  MarketStatusTitleLabel.swift
//  CryptoBuzz
//
//  Created by Ajay Choudhary on 08/01/20.
//  Copyright © 2020 Ajay Choudhary. All rights reserved.
//

import UIKit

class MarketStatusTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, textColor: UIColor, textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        text = title
        self.textColor = textColor
        self.textAlignment = textAlignment
        font = .systemFont(ofSize: 16)
    }
    

}
