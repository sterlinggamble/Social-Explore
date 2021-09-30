//
//  HomeViewController.swift
//  Social Explore
//
//  Created by Sterling Gamble on 8/26/21.
//

import UIKit

class HomeViewController: UIViewController {
        
    let topicsStackView = UIStackView()
    
    var topics = [Topic]()
    var posts = [Any]()
    
    var count = 0
        
    private let topicsCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 6)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.alwaysBounceHorizontal = true
        cv.allowsMultipleSelection = true
        cv.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        cv.register(TopicTagCell.self, forCellWithReuseIdentifier: "TopicTagCell")
        return cv
    }()
    
    private let postsCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.alwaysBounceVertical = true
        cv.showsVerticalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        cv.register(PostCell.self, forCellWithReuseIdentifier: "PostCell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        topicsCV.delegate = self
        topicsCV.dataSource = self
        
        postsCV.delegate = self
        postsCV.dataSource = self
        
        view.addSubview(topicsCV)
        view.addSubview(postsCV)
        
        data()
        style()
        layout()
        
        print(topics)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func data() {
        topics = [Topic(title: "All"), Topic(title: "Sports"), Topic(title: "Cars")]
        topics += [Topic(title: "Stocks"), Topic(title: "Funny"), Topic(title: "Politics")]
        posts = []
    }

}

extension HomeViewController {
    func style() {
        topicsCV.translatesAutoresizingMaskIntoConstraints = false
        postsCV.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            topicsCV.heightAnchor.constraint(equalToConstant: 28),
            topicsCV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topicsCV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: topicsCV.trailingAnchor),
            
            postsCV.topAnchor.constraint(equalTo: topicsCV.bottomAnchor, constant: 19),
            postsCV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: postsCV.trailingAnchor),
            postsCV.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.topicsCV {
            return topics.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.postsCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
            cell.nameLabel1.text = "Bruh Bruh"
            cell.nameLabel2.text = "@bruhbruh"
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicTagCell", for: indexPath) as! TopicTagCell
        cell.topicLabel.text = topics[indexPath.row].title
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.postsCV {
            return CGSize(width: view.bounds.width, height: 170)
        }
        // dynamically sizes the cell width to the label size
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.text = topics[indexPath.row].title
        label.sizeToFit()
        label.frame = CGRect(x: 15, y: 0, width: label.bounds.width, height: label.bounds.height)
        return CGSize(width: label.frame.width+30, height: 28)
    }
    

}
