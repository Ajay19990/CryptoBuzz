//
//  DetailViewController.swift
//  CryptoBuzz
//
//  Created by Ajay Choudhary on 17/12/19.
//  Copyright © 2019 Ajay Choudhary. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var coin: Coin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
    }
    
}
