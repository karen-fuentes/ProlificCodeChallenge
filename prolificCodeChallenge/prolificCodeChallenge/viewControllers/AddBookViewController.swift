//
//  AddBookViewController.swift
//  prolificCodeChallenge
//
//  Created by Karen Fuentes on 8/11/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
       let stackView = UIStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setNavigationBar()
        viewHierarchy()
        configureConstraint()
    }



    func setNavigationBar() {
        self.navigationItem.title = "Add Book"
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(doneButtonWasTapped))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func doneButtonWasTapped() {
        if titleTextField.text != "" || publisherTextField.text != "" ||
            authorTextField.text != "" || categoriesTextField.text != "" {
            alertUserOfLosingInfo()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func alertUserOfLosingInfo() {
        let alertController = UIAlertController(title: "Are you sure you want to leave?", message: "You are going to lose your info", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(action1)
        alertController.addAction(action2)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func configureConstraint() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        authorTextField.translatesAutoresizingMaskIntoConstraints = false
        publisherTextField.translatesAutoresizingMaskIntoConstraints = false
        categoriesTextField.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        let _ = [
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100.0),
            
            titleTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            titleTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            
            authorTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            authorTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            authorTextField.heightAnchor.constraint(equalToConstant: 40),
            
            publisherTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            publisherTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            publisherTextField.heightAnchor.constraint(equalToConstant: 40),
            
            categoriesTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            categoriesTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            categoriesTextField.heightAnchor.constraint(equalToConstant: 40),
            
            submitButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.25),
            ].map({$0.isActive = true})
    }
    
    func viewHierarchy() {
        stackView.axis  = UILayoutConstraintAxis.vertical
        stackView.distribution  = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing = 16.0
        
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(authorTextField)
        stackView.addArrangedSubview(publisherTextField)
        stackView.addArrangedSubview(categoriesTextField)
        
        self.view.addSubview(stackView)
        self.view.addSubview(submitButton)
    }
    
    lazy var titleTextField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Title"
        txtField.backgroundColor = .gray
        txtField.textAlignment = .center
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    lazy var authorTextField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Author"
        txtField.backgroundColor = .gray
        txtField.textAlignment = .center
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    lazy var publisherTextField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Publisher"
        txtField.backgroundColor = .gray
        txtField.textAlignment = .center
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    lazy var categoriesTextField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Categories"
        txtField.backgroundColor = .gray
        txtField.textAlignment = .center
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
