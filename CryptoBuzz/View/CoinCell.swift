//
//  AssetCell.swift
//  CryptoBuzz
//
//  Created by Ajay Choudhary on 12/12/19.
//  Copyright © 2019 Ajay Choudhary. All rights reserved.
//

import UIKit
import SVGKit

class CoinCell: UITableViewCell {
    
    let coinImageView = SVGKFastImageView(frame: .zero)
    let titleLabel = UILabel()
    let symbolLabel = UILabel()
    let priceLabel = UILabel()
    let arrowImageView = UIImageView()
    let changeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupPriceLabel()
        setupAssetImageView()
        setupAssetTitleLabel()
        setupAssetDescriptionLabel()
        setupArrowImageView()
        setupChangeLabel()
    }
    
    private func setupAssetImageView() {
        addSubview(coinImageView)
        
        coinImageView.translatesAutoresizingMaskIntoConstraints = false
        let leading = coinImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        let centerY = coinImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        let height = coinImageView.heightAnchor.constraint(equalToConstant: 40)
        let width = coinImageView.widthAnchor.constraint(equalToConstant: 40)
        NSLayoutConstraint.activate([leading, centerY, height, width])
        
        coinImageView.backgroundColor = .systemGray4
        coinImageView.clipsToBounds = true
        coinImageView.layer.cornerRadius = 40 / 2
    }
    
    private func setupAssetTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let top = titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12)
        let leading = titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70)
        let trailing = titleLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor)
        let height = titleLabel.heightAnchor.constraint(equalToConstant: 30)
        NSLayoutConstraint.activate([top, leading, trailing, height])
        
        titleLabel.font = UIFont(name: "Avenir-Roman", size: 19)
    }
    
    private func setupAssetDescriptionLabel() {
        addSubview(symbolLabel)
        
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        let top = symbolLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        let leading = symbolLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        let trailing = symbolLabel.widthAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([top, leading, trailing])
        
        symbolLabel.textColor = .lightGray
        symbolLabel.font = UIFont(name: "Avenir-Roman", size: 13)
    }
    
    private func setupPriceLabel() {
        addSubview(priceLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerY = priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        let trailing = priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14)
        let height = priceLabel.heightAnchor.constraint(equalToConstant: 30)
        let width = priceLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35)
        NSLayoutConstraint.activate([centerY, trailing, height, width])
        
        priceLabel.textAlignment = .right
        priceLabel.font = UIFont(name: "Avenir-Roman", size: 18)
    }
    
    private func setupArrowImageView() {
        addSubview(arrowImageView)
        
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        let top = arrowImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        let leading = arrowImageView.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor)
        let height = arrowImageView.heightAnchor.constraint(equalToConstant: 16)
        let width = arrowImageView.widthAnchor.constraint(equalToConstant: 16)
        NSLayoutConstraint.activate([top, leading, height, width])
    }
    
    private func setupChangeLabel() {
        addSubview(changeLabel)
        
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        let top = changeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        let leading = changeLabel.leadingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: 3)
        let width = changeLabel.widthAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([top, leading, width])
        changeLabel.font = UIFont(name: "Avenir-Roman", size: 13)
    }
    
}
