//
//  TopicTagCell.swift
//  Social Explore
//
//  Created by Sterling Gamble on 8/28/21.
//

import UIKit

class TopicTagCell: UICollectionViewCell {
    static let identifier = "TopicTagCell"
    
    let topicLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9607843137, alpha: 1)
        contentView.layer.cornerRadius = 14
        contentView.addSubview(topicLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        topicLabel.sizeToFit()
        topicLabel.frame = CGRect(x: 15, y: 7, width: topicLabel.bounds.width, height: topicLabel.bounds.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                contentView.backgroundColor = .black
                topicLabel.textColor = .white
            } else {
                contentView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9607843137, alpha: 1)
                topicLabel.textColor = .black
            }
        }
    }
    
}
