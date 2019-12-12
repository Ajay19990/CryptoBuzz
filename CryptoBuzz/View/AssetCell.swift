//
//  AssetCell.swift
//  CryptoBuzz
//
//  Created by Ajay Choudhary on 12/12/19.
//  Copyright © 2019 Ajay Choudhary. All rights reserved.
//

import UIKit

class AssetCell: UITableViewCell {
    
    let assetImageView = UIImageView()
    let assetTitleLabel = UILabel()
    let assetDescriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupAssetImageView()
        setupAssetTitleLabel()
        setupAssetDescriptionLabel()
    }
    
    private func setupAssetImageView() {
        addSubview(assetImageView)
        
        assetImageView.translatesAutoresizingMaskIntoConstraints = false
        let leading = assetImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        let centerY = assetImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        let height = assetImageView.heightAnchor.constraint(equalToConstant: 40)
        let width = assetImageView.widthAnchor.constraint(equalToConstant: 40)
        NSLayoutConstraint.activate([leading, centerY, height, width])
        
        assetImageView.backgroundColor = .systemGray4
        assetImageView.layer.cornerRadius = 40 / 2
    }
    
    private func setupAssetTitleLabel() {
        addSubview(assetTitleLabel)
        
        assetTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        let top = assetTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12)
        let leading = assetTitleLabel.leadingAnchor.constraint(equalTo: assetImageView.trailingAnchor, constant: 12)
        let trailing = assetTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        let height = assetTitleLabel.heightAnchor.constraint(equalToConstant: 30)
        NSLayoutConstraint.activate([top, leading, trailing, height])
        
        //assetTitleLabel.backgroundColor = .systemGray4
        assetTitleLabel.font = UIFont(name: "Avenir-Roman", size: 18)
    }
    
    private func setupAssetDescriptionLabel() {
        addSubview(assetDescriptionLabel)
        
        assetDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let top = assetDescriptionLabel.topAnchor.constraint(equalTo: assetTitleLabel.bottomAnchor)
        let leading = assetDescriptionLabel.leadingAnchor.constraint(equalTo: assetTitleLabel.leadingAnchor)
        let trailing = assetDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        NSLayoutConstraint.activate([top, leading, trailing])
        
        assetDescriptionLabel.textColor = .lightGray
        assetDescriptionLabel.font = .systemFont(ofSize: 13)
        assetDescriptionLabel.text = "BTC • Tradeable"
    }
    
}
