//
//  PostCell.swift
//  Social Explore
//
//  Created by Sterling Gamble on 8/30/21.
//

import UIKit

class PostCell: UICollectionViewCell {
    static let identifier = "PostCell"
    
    var post: Any?
    
    let nameStackView = UIStackView()
    let headerStackView = UIStackView()
    let bodyStackView = UIStackView()
    let footerStackView = UIStackView()
        
    let nameLabel1: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let nameLabel2: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.6)
        return label
    }()
    
     let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "If anyone is attending today’s Zendesk keynote let’s meet! I’m here till 4."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let backImageView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8117647059, green: 0.8117647059, blue: 0.8117647059, alpha: 1)
        view.layer.masksToBounds = true
//        view.layer.cornerRadius = view.bounds.width / 2
        return view
    }()
    
    private let optionsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.5960784314, green: 0.6392156863, blue: 0.7137254902, alpha: 1)
        return button
    }()
    
    private let favButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .black
        button.setBackgroundImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.8117647059, green: 0.831372549, blue: 0.8470588235, alpha: 1)
        button.addTarget(self, action: #selector(favorite), for: .touchUpInside)
        return button
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func favorite() {
        favButton.tintColor = .black
//        print("pressed")
    }
    
    func style() {
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.axis = .vertical
        nameLabel1.translatesAutoresizingMaskIntoConstraints = false
        nameLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.spacing = 10
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backImageView.layoutIfNeeded()
        backImageView.layer.cornerRadius = backImageView.bounds.width / 2
        
        headerStackView.alignment = .top
    }
    
    func layout2() {
        contentView.addSubview(backImageView)
        
        NSLayoutConstraint.activate([
            backImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
    
    func layout() {
        nameStackView.addArrangedSubview(nameLabel1)
        nameStackView.addArrangedSubview(nameLabel2)
        
        headerStackView.addArrangedSubview(backImageView)
        headerStackView.addArrangedSubview(nameStackView)
        headerStackView.addArrangedSubview(optionsButton)
        
        contentView.addSubview(headerStackView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(favButton)
        contentView.addSubview(divider)
        
//        bodyStackView.addArrangedSubview(contentLabel)
//        contentView.addSubview(bodyStackView)
        
        NSLayoutConstraint.activate([
            nameLabel1.topAnchor.constraint(equalTo: headerStackView.topAnchor, constant: 3.5),
            nameLabel2.topAnchor.constraint(equalTo: nameLabel1.bottomAnchor, constant: 5),
            
            // header contraints
            headerStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            headerStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 3),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: headerStackView.trailingAnchor, multiplier: 3),
//            headerStackView.heightAnchor.constraint(equalToConstant: 40),
            
            
            backImageView.widthAnchor.constraint(equalToConstant: 40),
            backImageView.heightAnchor.constraint(equalToConstant: 40),
            
            optionsButton.widthAnchor.constraint(equalToConstant: 25),
            optionsButton.heightAnchor.constraint(equalToConstant: 22),
//            optionsButton.topAnchor.constraint(equalTo: headerStackView.topAnchor, constant: 15),
//            optionsButton.bottomAnchor.constraint(equalTo: headerStackView.bottomAnchor)
            
            // post content contraints TODO: add stack for
            contentLabel.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 20),
            contentLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 3),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: contentLabel.trailingAnchor, multiplier: 3),
            
            favButton.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: favButton.trailingAnchor, multiplier: 3),
            favButton.widthAnchor.constraint(equalToConstant: 26),
            favButton.heightAnchor.constraint(equalToConstant: 26),
            
            divider.topAnchor.constraint(equalTo: favButton.bottomAnchor, constant: 20),
            divider.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 3),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: divider.trailingAnchor, multiplier: 3),
            divider.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}
