//
//  BookTableViewController.swift
//  prolificCodeChallenge
//
//  Created by Karen Fuentes on 8/11/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit

// Using a UI Table View Controller to show the list of books for the user. It is powered by an array of type Book which is created by the get request from server. Data source methods for the table view is in the view controller extension folder.

class BookTableViewController: UITableViewController {
    
    // MARK: -Properties
    var collectionOfBooks = [Book]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - View life cycle methods
    // 1. registers cell reuse identifier
    // 2. set background color
    // 3. makes a get request of all books calling the loadBooks() method
    // 4. calls the setUpNavigationItems() to set up items for the navation item (buttons and titles)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(BookTableViewCell.self, forCellReuseIdentifier: "book cell")
        self.view.backgroundColor = .lilac
        self.setUpNavigationItems()
        self.loadBooks()
    }
    
    // calls loadbooks() whenever view appears.
    //In this case when a book is added we make a get request to server to add newly added book to the table view controller
    override func viewDidAppear(_ animated: Bool) {
        self.loadBooks()
    }
    
    // MARK: - UI Navigation set up
    // function takes in no input and sets up all the navigation item
    private func setUpNavigationItems() {
        //title
        self.navigationItem.title = "Books"
        //left bar button (add)
        let addNavButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonWasTapped))
        self.navigationItem.leftBarButtonItem = addNavButton
        //right bar button (delete all)
        let deleteAllNavButton = UIBarButtonItem.init(title: "Delete All", style: .plain, target: self, action: #selector(self.deleteAllButtonWasTapped))
        self.navigationItem.rightBarButtonItem = deleteAllNavButton
        self.navigationItem.rightBarButtonItem?.tintColor = .red
    }
    
    // MARK: - Network Call
    // makes get request using BookAPICLient get all books function in which once the completion handler is complete
    // it sets the collection of books (array of book objects) with the book object we got back from the request
    private func loadBooks() {
        BooksAPIClient.manager.getAllBooks(completionHandler: {
            self.collectionOfBooks = $0
        }) { (error) in
            print(error)
        }
    }
    
    // MARK: - Navigation Item Button Functionality
    @objc private func deleteAllButtonWasTapped(){
        //alerts user to ask if they are sure they want to delete all the books
        let alert = UIAlertController(title: "Delete All", message: "Are you sure you want to delete all of your books? 🤔", preferredStyle: UIAlertControllerStyle.alert)
        //delete button
        alert.addAction(UIAlertAction(title: "Delete", style:  UIAlertActionStyle.destructive, handler: { (alert) in
            // when delete is pressed /clean/ endpoint is used with delete request
            BooksAPIClient.manager.delete(allBooks: true, book: nil, completionHandler: { (response) in
                DispatchQueue.main.async {
                    //load books again since data has changed
                    self.loadBooks()
                }
            }, errorHandler: {print($0)})
        }))
        //cancel button
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: { (alert) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // function that takes no input and makes navigation controller present the add book view controller
    // modally so that user can add a book when add book button is pressed
    @objc private func addButtonWasTapped() {
        let navController = UINavigationController(rootViewController: AddBookViewController())
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
}
