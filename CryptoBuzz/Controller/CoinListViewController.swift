//
//  AssetsViewController.swift
//  CryptoBuzz
//
//  Created by Ajay Choudhary on 12/12/19.
//  Copyright © 2019 Ajay Choudhary. All rights reserved.
//

import UIKit

class CoinListViewController: UIViewController {

    let tableView = UITableView()
    var coins = [Coin]()
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoinRankingClient.fetchCoins { (coins, error) in
            if let error = error {
                self.presentAlert(title: "An error occured", message: error.localizedDescription)
                return
            }
            self.coins = coins
            self.tableView.reloadData()
        }
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
        
        tableView.register(CoinCell.self, forCellReuseIdentifier: "cellId")
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension CoinListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CoinCell
        let coin = coins[indexPath.row]
        cell.titleLabel.text = coin.name
        cell.descriptionLabel.text = coin.symbol
        
        if let price = Double(coin.price) {
            let formatted = String(format: "US$ %.2f", price)
            cell.priceLabel.text = formatted
        }
        
        CoinRankingClient.fetchIcon(urlString: coin.iconUrl) { (image, error) in
            if error == nil {
                DispatchQueue.main.async {
                    cell.coinImageView.image = image
                }
            }
        }
        return cell
    }
    
}


extension UIViewController {
    func presentAlert(title: String, message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(alertAction)
        present(alertVC, animated: true)
    }
}
