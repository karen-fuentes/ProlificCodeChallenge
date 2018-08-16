//
//  BookDetailView.swift
//  prolificCodeChallenge
//
//  Created by Karen Fuentes on 8/15/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit

class BookDetailView: UIView {
    
    let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lilac
        setUpViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .lilac
        setUpViews()
        configureConstraints()
    }
    
    
    func configureConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        publisherLabel.translatesAutoresizingMaskIntoConstraints = false
        lastCheckedOutByLabel.translatesAutoresizingMaskIntoConstraints = false
        categoriesLabel.translatesAutoresizingMaskIntoConstraints = false
        // self.edgesForExtendedLayout = []
        
        let _ = [
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            checkoutButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            checkoutButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            checkoutButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            authorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            authorLabel.heightAnchor.constraint(equalToConstant: 40),
            
            publisherLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            publisherLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            publisherLabel.heightAnchor.constraint(equalToConstant: 40),
            
            categoriesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            categoriesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            categoriesLabel.heightAnchor.constraint(equalToConstant: 40),
            
            lastCheckedOutByLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            lastCheckedOutByLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            lastCheckedOutByLabel.heightAnchor.constraint(equalToConstant: 40),
            
            deleteButton.topAnchor.constraint(equalTo: checkoutButton.bottomAnchor, constant: 20),
            deleteButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            ].map({$0.isActive = true })
        
        
        
    }
    
    func setUpViews() {
        stackView.axis  = UILayoutConstraintAxis.vertical
        stackView.distribution  = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.center
        stackView.backgroundColor = .black
        stackView.spacing = 16.0
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(publisherLabel)
        stackView.addArrangedSubview(categoriesLabel)
        stackView.addArrangedSubview(lastCheckedOutByLabel)
        
        self.addSubview(stackView)
        self.addSubview(checkoutButton)
        self.addSubview(deleteButton)
        
    }
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.backgroundColor = .lighterGray
        return lbl
    }()
    
    lazy var authorLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.backgroundColor = .lighterGray
        return lbl
    }()
    
    lazy var publisherLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "Avenir-Light", size: 14)
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.backgroundColor = .lighterGray
        return lbl
    }()
    
    lazy var categoriesLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "Avenir-Light", size: 14)
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.backgroundColor = .lighterGray
        return lbl
    }()
    
    lazy var lastCheckedOutByLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "Avenir-Light", size: 14)
        lbl.numberOfLines = 3
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.backgroundColor = .lighterGray
        return lbl
    }()
    
    lazy var checkoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Check Out", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.backgroundColor = .gray
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete Book", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()

}