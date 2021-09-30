//
//  ProfileViewController.swift
//  Social Explore
//
//  Created by Sterling Gamble on 8/26/21.
//

import UIKit

class ProfileViewController: UIViewController {

    let locationButton = UIButton()
    let glassButton = UIButton()
    let searchTextField = UITextField()
    let searchStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        style()
        layout()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileViewController {
    func style() {
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        searchStackView.spacing = 8
        
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        locationButton.tintColor = .label
        
        glassButton.translatesAutoresizingMaskIntoConstraints = false
        glassButton.setBackgroundImage(UIImage(systemName: "ellipsis"), for: .normal)
        glassButton.tintColor = .label
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.font = UIFont.preferredFont(forTextStyle: .title1)
        searchTextField.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        searchTextField.placeholder = "Search"
        searchTextField.textAlignment = .right
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = .systemFill
    }
    
    func layout() {
//        view.addSubview(locationButton)
//        view.addSubview(glassButton)
//        view.addSubview(searchTextField)
        
        searchStackView.addArrangedSubview(locationButton)
        searchStackView.addArrangedSubview(searchTextField)
        searchStackView.addArrangedSubview(glassButton)
        
        view.addSubview(searchStackView)
        
        NSLayoutConstraint.activate([
//            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            locationButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            // search
            searchStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchStackView.trailingAnchor, multiplier: 1),
            
            
            locationButton.widthAnchor.constraint(equalToConstant: 40),
            locationButton.heightAnchor.constraint(equalToConstant: 40),
            
//            glassButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            glassButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
//            view.trailingAnchor.constraint(equalToSystemSpacingAfter: glassButton.trailingAnchor, multiplier: 1),
            glassButton.widthAnchor.constraint(equalToConstant: 30),
            glassButton.heightAnchor.constraint(equalToConstant: 25),
            
//            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            searchTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: locationButton.trailingAnchor, multiplier: 1),
//            glassButton.leadingAnchor.constraint(equalToSystemSpacingAfter: searchTextField.trailingAnchor, multiplier: 1),
            
            
        ])
        
        
        
    }
}
