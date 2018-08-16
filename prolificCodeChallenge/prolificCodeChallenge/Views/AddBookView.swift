//
//  AddBookView.swift
//  prolificCodeChallenge
//
//  Created by Karen Fuentes on 8/15/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//
import UIKit
// view for addBookDetailVC in order to adhere to MVC and to declutter the view controller
class AddBookView: UIView {
    // MARK: - Properties
    var stackView = UIStackView()
    
    // MARK: init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGreen
        self.viewHierarchy()
        self.configureConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .lightGreen
        self.viewHierarchy()
        self.configureConstraint()
    }
    
    // MARK: - Constraints
    private func configureConstraint() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        authorTextField.translatesAutoresizingMaskIntoConstraints = false
        publisherTextField.translatesAutoresizingMaskIntoConstraints = false
        categoriesTextField.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        let _ = [
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100.0),
            
            titleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            
            authorTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            authorTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            authorTextField.heightAnchor.constraint(equalToConstant: 40),
            
            publisherTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            publisherTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            publisherTextField.heightAnchor.constraint(equalToConstant: 40),
            
            categoriesTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            categoriesTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            categoriesTextField.heightAnchor.constraint(equalToConstant: 40),
            
            submitButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            submitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            submitButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.25),
            ].map({$0.isActive = true})
    }
    
    // MARK: - View hierarchy
    private func viewHierarchy() {
        stackView.axis  = UILayoutConstraintAxis.vertical
        stackView.distribution  = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing = 16.0
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(authorTextField)
        stackView.addArrangedSubview(publisherTextField)
        stackView.addArrangedSubview(categoriesTextField)
        self.addSubview(stackView)
        self.addSubview(submitButton)
    }
    
    // MARK: - UI Objects
    lazy var titleTextField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Title"
        txtField.backgroundColor = .lighterGray
        txtField.textAlignment = .center
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    lazy var authorTextField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Author"
        txtField.backgroundColor = .lighterGray
        txtField.textAlignment = .center
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    lazy var publisherTextField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Publisher"
        txtField.backgroundColor = .lighterGray
        txtField.textAlignment = .center
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    lazy var categoriesTextField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Categories"
        txtField.backgroundColor = .lighterGray
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
        button.backgroundColor = .lilac
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
}
