//
//  HomeViewController.swift
//  DynamicList
//
//  Created by Saurabh Mirajkar on 05/03/22.
//

import UIKit

class HomeViewController: UIViewController {

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter URL"
        textField.keyboardType = .URL
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.backgroundColor = .black
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        button.center = view.center
    }
    
    @objc func didTapButton() {
        // Check URL
        if textField.text?.trimmingCharacters(in: .whitespaces) == "" {
            self.showAlert()
        } else {
            // Navigate to list screen
            let listViewController = ListViewController()
            listViewController.enteredURL = textField.text!
            self.navigationController?.pushViewController(listViewController, animated: true)
        }
    }
    
    private func setupNavigationView() {
        if #available(iOS 13, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            navigationItem.standardAppearance = appearance
            navigationItem.scrollEdgeAppearance = appearance
            navigationItem.compactAppearance = appearance
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(button)
        view.addSubview(textField)
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -80).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Missing URL", message: "Please enter URL", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }


}

