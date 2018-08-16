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
    // MARK: - Properties
    var book: Book!
    var bookView = BookDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = bookView
        self.view.backgroundColor = .lighterGray
        self.setLabels(book: book)
        self.setNavigationBar()
        //target actions
        self.bookView.checkoutButton.addTarget(self, action: #selector(checkOutButtonWasTapped), for: .touchUpInside)
        self.bookView.deleteButton.addTarget(self, action: #selector(deleteButtonWasPressed), for: .touchUpInside)
        self.bookView.edit.addTarget(self, action: #selector(editButtonWasTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getBookWithID(id: book.id, checkingOut: false)
    }
    
    //MARK: Setting labels, targets, navigation item
    //sets all the labels when viewDidLoad is called
    //add target to button
    private func setLabels(book: Book, checkingOut: Bool = false) {
        self.bookView.titleLabel.text = "Title:  \(self.book.title)"
        self.bookView.authorLabel.text = "Author: \(self.book.author)"
        self.bookView.publisherLabel.text = "Publishers: \(self.book.publisher)"
        self.bookView.categoriesLabel.text = "Categories: \(self.book.categories)"
        guard let time = self.book.lastCheckedOut else{return}
        guard let borrower = self.book.lastCheckedOutBy else {return}
        //only when checking out... checkout by is updated
        if checkingOut {
            self.bookView.lastCheckedOutByLabel.text = "Last Checked Out By: \(borrower) @ \(time.dateStringToReadableString())"
        }
    }
    
    //setting share naviagtion item and bar title
    private func setNavigationBar() {
        self.title = "Detail"
        let shareButton = UIBarButtonItem.init(title: "Share", style: .plain, target: self, action: #selector(shareButtonWasPressed))
        self.navigationItem.rightBarButtonItem = shareButton
    }
    
    // MARK: - Share Function
    // when share button is pressed iOS share sheet is presented for user to share
    @objc private func shareButtonWasPressed() {
        let bookToShare = "Hey I want to share this book: \(self.book.title), by: \(self.book.author)"
        let activityController = UIActivityViewController(activityItems: [bookToShare], applicationActivities: nil)
        activityController.excludedActivityTypes = [UIActivityType.postToWeibo,
                                                    UIActivityType.message,
                                                    UIActivityType.mail,
                                                    UIActivityType.print,
                                                    UIActivityType.copyToPasteboard,
                                                    UIActivityType.assignToContact,
                                                    UIActivityType.saveToCameraRoll,
                                                    UIActivityType.addToReadingList,
                                                    UIActivityType.postToFlickr,
                                                    UIActivityType.postToVimeo,
                                                    UIActivityType.postToTencentWeibo,
                                                    UIActivityType.airDrop];
        self.present(activityController, animated: true, completion: nil)
    }
    
    // MARK: - PUT Request
    //when checkout is pressed -> user is promted to give a name to check out
    //once the name is captured a put request is made
    // view is update with checkedout name and time
    @objc private func checkOutButtonWasTapped() {
        let alert = UIAlertController(title: "Please input your name", message: nil , preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            let txtField = alert.textFields![0] as UITextField
            guard let name = txtField.text else {return}
            self.book.lastCheckedOutBy = name
            //PUT Request - once its successful a get request with id is made to update view
            BooksAPIClient.manager.editOrCreateBook(requestMethod: .put, book: self.book, completionHandler: { (response) in
                self.getBookWithID(id: self.book.id, checkingOut: true)
            }, errorHandler: {print($0)})
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your name"
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK - DELETE request
    // 1. alerts user if they want to delete book
    // 2. if they press delete a delete request is made
    //    if the delete is successful user is taken to book table view controller
    // 3. if the user does not want to delete the alert controller is dismissed
    @objc private func deleteButtonWasPressed() {
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this book?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: { (alert) in
            //delete request
            BooksAPIClient.manager.delete(allBooks: false, book: self.book, completionHandler: { (response) in
                // successful delete request alerts user the the delete was successful
                let successfulDeleteAlert = UIAlertController(title: "Succesful!", message: "You Succesfully Deleted This Book", preferredStyle: UIAlertControllerStyle.alert)
                successfulDeleteAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alert) in
                    self.dismiss(animated: true, completion: nil)
                    // once ok is pressed the navigation controller pops the detail VC
                    _ = self.navigationController?.popViewController(animated: true)
                }))
                self.present(successfulDeleteAlert, animated: true, completion: nil)
            }, errorHandler: {print($0)})
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: { (alert) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Target Method
    @objc private func editButtonWasTapped() {
        let destinationVC = EditBookViewController()
        destinationVC.book = self.book
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    //MARK: - GET WITH ID
    // if user checks out book a get request with id number needs to be made to update the view
    func getBookWithID(id: Int, checkingOut: Bool) {
        let stringID = String(id)
        //get with id request
        BooksAPIClient.manager.getBookWith(id: stringID, completionHandler: { (response) in
            //when completion handler comes back it updates the labels
            self.book = response
            self.setLabels(book: self.book, checkingOut: checkingOut)
        }, errorHandler: {print($0)})
    }
}
