//
//  timeFrameButton.swift
//  CryptoBuzz
//
//  Created by Ajay Choudhary on 07/01/20.
//  Copyright © 2020 Ajay Choudhary. All rights reserved.
//

import UIKit

class TimeFrameButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layer.cornerRadius = 10
        backgroundColor = .systemPink
        translatesAutoresizingMaskIntoConstraints = false
    }
}
