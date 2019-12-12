//
//  AssetsViewController.swift
//  CryptoBuzz
//
//  Created by Ajay Choudhary on 12/12/19.
//  Copyright © 2019 Ajay Choudhary. All rights reserved.
//

import UIKit

class AssetsViewController: UIViewController {

    let tableView = UITableView()
    let currencies = ["Bitcoin", "Ethereum", "XRP", "Tether", "Bitcoin Cash", "Litecoin", "EOS", "Binance Coin"]
    
    override func loadView() {
        super.loadView()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = 72.5
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let leading = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let top = tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let trailing = tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottom = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([leading, top, trailing, bottom])
        
        tableView.register(AssetCell.self, forCellReuseIdentifier: "cellId")
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension AssetsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! AssetCell
        cell.assetTitleLabel.text = currencies[indexPath.row]
        return cell
    }
    
}
