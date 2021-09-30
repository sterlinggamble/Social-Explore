//
//  TwitterPostCell.swift
//  Social Explore
//
//  Created by Sterling Gamble on 8/30/21.
//

import UIKit

class TwitterPostCell: UICollectionViewCell {
    static let identifier = "TwitterPostCell"
    
    let stackView = UIStackView()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
        
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.6)
        return label
    }()
}
