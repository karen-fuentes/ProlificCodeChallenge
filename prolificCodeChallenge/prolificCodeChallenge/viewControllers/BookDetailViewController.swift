//
//  BookDetailViewController.swift
//  prolificCodeChallenge
//
//  Created by Karen Fuentes on 8/13/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit
import Social

class BookDetailViewController: UIViewController {
    var book: Book!
    let stackView = UIStackView()
    var name = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        self.view.backgroundColor = .red
        setUpViews()
        configureConstraints()
        setNavigationBar()
        
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "Share"
        let shareButton = UIBarButtonItem.init(title: "Share", style: .plain, target: self, action: #selector(shareButtonWasPressed))
        //init(barButtonSystemItem: .done, target: self, action: #selector(shareButtonWasPressed))
        self.navigationItem.rightBarButtonItem = shareButton
    }
    
    @objc func shareButtonWasPressed() {
       let activityController = UIActivityViewController(activityItems: [self.book], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
       // activityController.excludedActivityTypes = [UIActivityT]
    }
    
    @objc func checkOutButtonWasTapped() {
        let alert = UIAlertController(title: "Please input your name", message: nil , preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            let txtField = alert.textFields![0] as UITextField
            self.name = txtField.text!
            self.book.lastCheckedOutBy = self.name
            //self.book.lastCheckedOutBy = "Karen"
            BooksAPIClient.manager.updateBook(book: self.book, completionHandler: { (respond) in
            }, errorHandler: {print($0)})
        }
    
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your name"
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
      
    }
    
   @objc func deleteButtonWasPressed() {
        BooksAPIClient.manager.deleteBook(book: self.book, completionHandler: { (respond) in
        }, errorHandler: {print($0)})
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let id = String(book.id)
        BooksAPIClient.manager.getBookWith(id: id, completionHandler: { (respond) in
        }, errorHandler: {print($0)})
        
    }

   
    func configureConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        publisherLabel.translatesAutoresizingMaskIntoConstraints = false
        lastCheckedOutByLabel.translatesAutoresizingMaskIntoConstraints = false
        lastCheckedOutLabel.translatesAutoresizingMaskIntoConstraints = false
        categoriesLabel.translatesAutoresizingMaskIntoConstraints = false
        // self.edgesForExtendedLayout = []
        
        let _ = [
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            
            checkoutButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            checkoutButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            checkoutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            authorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            authorLabel.heightAnchor.constraint(equalToConstant: 40),
            
            publisherLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            publisherLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            publisherLabel.heightAnchor.constraint(equalToConstant: 40),
            
            categoriesLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            categoriesLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            categoriesLabel.heightAnchor.constraint(equalToConstant: 40),
            
            lastCheckedOutByLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            lastCheckedOutByLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            lastCheckedOutByLabel.heightAnchor.constraint(equalToConstant: 40),
            
            lastCheckedOutLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            lastCheckedOutLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            lastCheckedOutLabel.heightAnchor.constraint(equalToConstant: 40),
        
            
            deleteButton.topAnchor.constraint(equalTo: checkoutButton.bottomAnchor, constant: 20),
            deleteButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            deleteButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15)
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
        stackView.addArrangedSubview(lastCheckedOutLabel)
        stackView.addArrangedSubview(lastCheckedOutByLabel)
        
        self.view.addSubview(stackView)
        self.view.addSubview(checkoutButton)
        self.view.addSubview(deleteButton)
        
    }
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
       // lbl.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
        lbl.numberOfLines = 2
        //lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.backgroundColor = .lightGray
        lbl.text = self.book.title
        return lbl
    }()
    
    lazy var authorLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        //lbl.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
        lbl.numberOfLines = 2
       // lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.backgroundColor = .lightGray
        lbl.text = self.book.title
        return lbl
    }()
    
    lazy var publisherLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
       // lbl.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)
        //lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.backgroundColor = .lightGray
        lbl.text = self.book.publisher
        return lbl
    }()
    
    lazy var categoriesLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        //lbl.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)
        lbl.numberOfLines = 2
        //lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.backgroundColor = .lightGray
        lbl.text = self.book.categories
        return lbl
    }()
    
    lazy var lastCheckedOutLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        //lbl.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)
        lbl.numberOfLines = 2
        //lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.backgroundColor = .lightGray
        lbl.text = self.book.lastCheckedOut
        return lbl
    }()
    
    lazy var lastCheckedOutByLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        //lbl.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)
        lbl.numberOfLines = 3
        //lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.backgroundColor = .lightGray
        lbl.text = self.book.lastCheckedOutBy
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
        button.addTarget(self, action: #selector(checkOutButtonWasTapped), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(deleteButtonWasPressed), for: .touchUpInside)
        return button
    }()
}
