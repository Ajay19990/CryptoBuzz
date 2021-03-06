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

extension UITableView {
    func setEmptyView(title: String, message: String) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        // Configure Title Label
        emptyView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerTitileY = titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -50)
        let centerTitleX = titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor)
        NSLayoutConstraint.activate([centerTitleX, centerTitileY])
        
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .label
        titleLabel.text = title
        
        emptyView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let centerMessageX = messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        let centerMessageY = messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor)
        NSLayoutConstraint.activate([centerMessageX, centerMessageY])
       
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.textColor = .label
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center

        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}


extension Double {
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

