//
//  Extensions.swift
//  CryptoBuzz
//
//  Created by Ajay Choudhary on 07/01/20.
//  Copyright © 2020 Ajay Choudhary. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlertOnMainThread(title: String, message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: true)
    }
}
