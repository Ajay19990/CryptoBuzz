//
//  DetailViewController.swift
//  CryptoBuzz
//
//  Created by Ajay Choudhary on 17/12/19.
//  Copyright © 2019 Ajay Choudhary. All rights reserved.
//

import UIKit
import SwiftChart

class DetailViewController: UIViewController {
    
    var coin: Coin!
    let chart = Chart(frame: .zero)
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    
    let marketCapImageView = UIImageView(image: UIImage(named: "bar-chart"))
    let volumeImageView = UIImageView(image: UIImage(named: "bars"))
    let allTimeHighImageView = UIImageView(image: UIImage(named: "allTimeHigh"))
    var imageStackView: UIStackView!
    var marketTitleStackView: UIStackView!
    var marketValueStackView: UIStackView!
    
    let marketCapTitleLabel = MarketStatusTitleLabel(title: "Market Capture", textColor: .label, textAlignment: .left)
    let volumeTitleLabel = MarketStatusTitleLabel(title: "Volume", textColor: .label, textAlignment: .left)
    let allTimeHighTitleLabel = MarketStatusTitleLabel(title: "All time high", textColor: .label, textAlignment: .left)
    
    override func loadView() {
        super.loadView()
        setup()
    }

    private func handleHistory(history: [History], error: String?) {
        if let error = error {
            DispatchQueue.main.async{
                self.presentAlertOnMainThread(title: "An error occured", message: error)
            }
            return
        }
        DispatchQueue.main.async{
            self.chart.removeAllSeries()
            let series = self.makeSeries(historyArray: history)
            self.chart.add(series)
            self.chart.reloadInputViews()
        }
    }
    
    private func makeSeries(historyArray: [History]) -> ChartSeries {
        var arr = [String]()
        for history in historyArray {
            let price = history.price
            arr.append(price)
        }
        
        let historySeries = arr.compactMap(Double.init)
        let series = ChartSeries(historySeries)
        series.color = ChartColors.blueColor()
        return series
    }
    
    private func setup() {
        view.backgroundColor = .systemBackground
        setupNavBar()
        setupTitleLabel()
        setupPriceLabel()
        setupChartView()
        setupTimeFrameStackView()
        setupMarketStatusStackView()
        setupMarketTitleStackView()
        setupMarketValueStackView()
    }
    
    private func setupNavBar() {
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        self.view.addSubview(navbar)

        let navItem = UINavigationItem(title: coin.name)
        let navBarbutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(dismissView))
        navItem.rightBarButtonItem = navBarbutton

        navbar.items = [navItem]
    }
    
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let top = titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 62)
        let leading = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let trailing = titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let height = titleLabel.heightAnchor.constraint(equalToConstant: 25)
        NSLayoutConstraint.activate([top, leading, trailing, height])
        
        titleLabel.text = "\(coin.name) price"
        titleLabel.textColor = .systemGray
        titleLabel.font = .systemFont(ofSize: 16)
    }
    
    private func setupPriceLabel() {
        view.addSubview(priceLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        let top = priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        let leading = priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let trailing = priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let height = priceLabel.heightAnchor.constraint(equalToConstant: 35)
        NSLayoutConstraint.activate([top, leading, trailing, height])
        
        if let price = Double(coin.price) {
            let formatted = String(format: "US$ %.2f", price)
            
            let attributedString = NSMutableAttributedString(string: formatted, attributes: [NSAttributedString.Key.font : UIFont(name: "Avenir-Roman", size: 22)!])
            if coin.change < 0 {
                attributedString.append(NSAttributedString(string: " \(coin.change)%", attributes: [NSAttributedString.Key.font : UIFont(name: "Avenir-Roman", size: 16)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9607843137, green: 0.3725490196, blue: 0.4, alpha: 1)]))
                
            } else if coin.change > 0 {
                attributedString.append(NSAttributedString(string: " +\(coin.change)%", attributes: [NSAttributedString.Key.font : UIFont(name: "Avenir-Roman", size: 16)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2352941176, green: 0.6784313725, blue: 0.262745098, alpha: 1)]))
            }
            priceLabel.attributedText = attributedString
        }
    }
    
    private func setupChartView() {
        view.addSubview(chart)
        
        chart.translatesAutoresizingMaskIntoConstraints = false
        let top = chart.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8)
        let leading = chart.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = chart.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let height = chart.heightAnchor.constraint(equalToConstant: 250)
        NSLayoutConstraint.activate([top, leading, trailing, height])
        
        chart.backgroundColor = .systemBackground
        chart.showXLabelsAndGrid = false
        chart.showYLabelsAndGrid = false
        chart.isUserInteractionEnabled = false
        
        CoinRankingClient.getCoinHistory(coinId: coin.id, timeFrame: "24h", completion: handleHistory)
    }
    
    private func setupTimeFrameStackView() {
        let oneDayButton = TimeFrameButton(title: "24h")
        let sevenDayButton = TimeFrameButton(title: "7d")
        let thirtyDayButton = TimeFrameButton(title: "30d")
        let oneYearButton = TimeFrameButton(title: "1y")
        let fiveYearButton = TimeFrameButton(title: "5y")
        
        oneDayButton.addTarget(self, action: #selector(timeFrameAction), for: .touchUpInside)
        sevenDayButton.addTarget(self, action: #selector(timeFrameAction), for: .touchUpInside)
        thirtyDayButton.addTarget(self, action: #selector(timeFrameAction), for: .touchUpInside)
        oneYearButton.addTarget(self, action: #selector(timeFrameAction), for: .touchUpInside)
        fiveYearButton.addTarget(self, action: #selector(timeFrameAction), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [oneDayButton, sevenDayButton, thirtyDayButton, oneYearButton, fiveYearButton])
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: chart.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            stackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupMarketStatusStackView() {
        imageStackView = UIStackView(arrangedSubviews: [marketCapImageView, volumeImageView, allTimeHighImageView])
        view.addSubview(imageStackView)
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.axis = .vertical
        imageStackView.distribution = .fillEqually
        imageStackView.spacing = 10
        
        NSLayoutConstraint.activate([
            imageStackView.topAnchor.constraint(equalTo: chart.bottomAnchor, constant: 58),
            imageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageStackView.widthAnchor.constraint(equalToConstant: 32),
            imageStackView.heightAnchor.constraint(equalToConstant: 116)
        ])
    }
    
    private func setupMarketTitleStackView() {
        marketTitleStackView = UIStackView(arrangedSubviews: [marketCapTitleLabel, volumeTitleLabel, allTimeHighTitleLabel])
        view.addSubview(marketTitleStackView)
        marketTitleStackView.translatesAutoresizingMaskIntoConstraints = false
        marketTitleStackView.axis = .vertical
        marketTitleStackView.distribution = .fillEqually
        marketTitleStackView.spacing = 10
        
        NSLayoutConstraint.activate([
            marketTitleStackView.topAnchor.constraint(equalTo: chart.bottomAnchor, constant: 58),
            marketTitleStackView.leadingAnchor.constraint(equalTo: imageStackView.trailingAnchor, constant: 12),
            marketTitleStackView.widthAnchor.constraint(equalToConstant: 120),
            marketTitleStackView.heightAnchor.constraint(equalToConstant: 116)
        ])
    }
    
    private func setupMarketValueStackView() {
        let marketCap = formatNumber(coin.marketCap)
        let marketCapLabel = MarketStatusTitleLabel(title: marketCap, textColor: .systemGray2, textAlignment: .right)
        
        let volume = formatNumber(coin.volume)
        let volumeLabel = MarketStatusTitleLabel(title: volume, textColor: .systemGray2, textAlignment: .right)
        
        let allTimeHigh = coin.allTimeHigh.price
        let allTimeHighLabel = MarketStatusTitleLabel(title: allTimeHigh, textColor: .systemGray2, textAlignment: .right)
        
        marketValueStackView = UIStackView(arrangedSubviews: [marketCapLabel, volumeLabel, allTimeHighLabel])
        view.addSubview(marketValueStackView)
        marketValueStackView.translatesAutoresizingMaskIntoConstraints = false
        marketValueStackView.axis = .vertical
        marketValueStackView.distribution = .fillEqually
        marketValueStackView.spacing = 10
        
        NSLayoutConstraint.activate([
            marketValueStackView.topAnchor.constraint(equalTo: chart.bottomAnchor, constant: 58),
            marketValueStackView.leadingAnchor.constraint(equalTo: marketTitleStackView.trailingAnchor),
            marketValueStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            marketValueStackView.heightAnchor.constraint(equalToConstant: 116)
        ])
    }
    
    @objc private func timeFrameAction(_ sender: TimeFrameButton) {
        let timeFrame = sender.currentTitle!
        CoinRankingClient.getCoinHistory(coinId: coin.id, timeFrame: timeFrame, completion: handleHistory)
    }
    
    func formatNumber(_ value: Int) -> String {
        let num = abs(Double(value))
        switch num {

        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.truncate(places: 1)
            return "\(formatted) Billion"

        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.truncate(places: 1)
            return "\(formatted) Million"

        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.truncate(places: 1)
            return "\(formatted) Thousand"

        case 0...:
            return "\(value)"

        default:
            return "\(value)"

        }
    }
}

extension Double {
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
