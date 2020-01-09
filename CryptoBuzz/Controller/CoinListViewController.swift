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
    var activityIndicatorContainer: UIView!
    var activityIndicator: UIActivityIndicatorView!
    var refreshButton: UIBarButtonItem!
    
    var coins = [Coin]()
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoinRankingClient.fetchCoins(completion: handleCoins)
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Last 24 hours"
        setupTableView()
        setupRefreshButton()
        setupActivityIndicator()
        showActivityIndicator(show: true)
    }
    
    private func setupRefreshButton() {
        refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        self.navigationItem.rightBarButtonItem = refreshButton
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
    
    private func setupActivityIndicator() {
        
        activityIndicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        activityIndicatorContainer.center.x = view.center.x
        activityIndicatorContainer.center.y = view.center.y
        activityIndicatorContainer.backgroundColor = UIColor.black
        activityIndicatorContainer.alpha = 0.8
        activityIndicatorContainer.layer.cornerRadius = 10
          
        // Configure the activity indicator
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorContainer.addSubview(activityIndicator)
        view.addSubview(activityIndicatorContainer)
            
        // Constraints
        activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorContainer.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorContainer.centerYAnchor).isActive = true
    }
    
    private func showActivityIndicator(show: Bool) {
      if show {
        DispatchQueue.main.async{
            self.tableView.allowsSelection = false
            self.tableView.isUserInteractionEnabled = false
            self.activityIndicator.startAnimating()
            self.refreshButton.isEnabled = false
        }
      } else {
            DispatchQueue.main.async{
                self.tableView.allowsSelection = true
                self.refreshButton.isEnabled = true
                self.tableView.isUserInteractionEnabled = true
                self.activityIndicator.stopAnimating()
                self.activityIndicatorContainer.removeFromSuperview()
            }
        }
    }
    
    @objc func refreshTapped() {
        self.coins = []
        setupActivityIndicator()
        showActivityIndicator(show: true)
        CoinRankingClient.fetchCoins(completion: handleCoins)
    }
    
    private func handleCoins(coins: [Coin], error: ErrorMessage?) {
        self.showActivityIndicator(show: false)
        if (error != nil) {
            DispatchQueue.main.async {
                self.presentAlertOnMainThread(title: "An error occured", message: error!.rawValue)
            }
        }
        self.coins = coins
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension CoinListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if coins.count == 0 {
            tableView.setEmptyView(title: "Data unavailable", message: "Unable to get the requested data.")
        } else {
            tableView.restore()
        }
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CoinCell
        
        let coin = coins[indexPath.row]
        cell.titleLabel.text = coin.name
        cell.symbolLabel.text = coin.symbol
        cell.changeLabel.text = "\(abs(coin.change))%"
        
        if coin.change < 0 {
            cell.arrowImageView.image = UIImage(named: "down.png")
            cell.changeLabel.textColor = #colorLiteral(red: 0.9607843137, green: 0.3725490196, blue: 0.4, alpha: 1)
        } else if coin.change > 0 {
            cell.changeLabel.textColor = #colorLiteral(red: 0.2352941176, green: 0.6784313725, blue: 0.262745098, alpha: 1)
            cell.arrowImageView.image = UIImage(named: "up.png")
        }
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.coin = coins[indexPath.row]
        self.present(detailViewController, animated: true, completion: tableView.reloadData)
    }
}
