//
//  AddBookViewController.swift
//  prolificCodeChallenge
//
//  Created by Karen Fuentes on 8/11/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
    let addBookView = AddBookView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = addBookView
        setNavigationBar()
        addBookView.submitButton.addTarget(self, action: #selector(submitButtonWasPressed), for: .touchUpInside)
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "Add Book"
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(doneButtonWasTapped))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    // MARK: - Button Functions
    // function is called when navigation done button is pressed
    // it checks if any of the text fields have data in them
    // if they do it alerts user that they may lose data
    // if thet want to leave page they will, if not they will stay in the add book page
    @objc private func doneButtonWasTapped() {
        if addBookView.titleTextField.text != "" || addBookView.publisherTextField.text != "" ||
            addBookView.authorTextField.text != "" || addBookView.categoriesTextField.text != "" {
            alertUserOfLosingInfo()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // function is called with add book views submit button is pressed
    // checks if author and title have values since those are required to make the post request
    // if those fields are missing user are alerted that fields are missing,
    // else post request is triggered
    @objc private func submitButtonWasPressed() {
        if addBookView.titleTextField.text == "" || addBookView.authorTextField.text == "" {
            self.alertUserOfMissingFields()
        }
        else {
            self.postBook()
        }
    }
    
    // MARK: - Networking
    // makes post request (adds book) 
    private func postBook(){
        // safely unwrap user input from text field
        guard let author = addBookView.authorTextField.text,
            let categories = addBookView.categoriesTextField.text,
            let publisher = addBookView.publisherTextField.text,
            let title = addBookView.titleTextField.text else {return}
        // create a book object to post
        let bookToPost = Book(author: author, categories: categories, id: 0, lastCheckedOut: nil, lastCheckedOutBy: nil, publisher: publisher, title: title, url: "")
        // use Book Api Client to make a post request once the completion handler is done i.e post request was made
        //user is notified that the book they created was made succesfully
        BooksAPIClient.manager.createBook(book: bookToPost, completionHandler: { (response) in
            self.alertUserBookWasPosted()
        }, errorHandler: { print($0) } )
    }
    
    // MARK: - Alert User Functions
    // once the completion handler comes back i.e a post request made succesfully
    // the user is alerted that the book was posted successfully
    private func alertUserBookWasPosted() {
        let alertController = UIAlertController(title: "The book Was Posted Successfully!", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // User cannot submit a book w/o title or author field so if these are missing an alert
    // is sent to the user to have input in those fields
    private func alertUserOfMissingFields(){
        let alertController = UIAlertController(title: "Missing Fields!", message: "You must have title and author in order to submit", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // When user presses done button and there are text fields that have text
    // the user is warned that they may lose their info they can either continue or cancel
    private func alertUserOfLosingInfo() {
        let alertController = UIAlertController(title: "Are you sure you want to leave?", message: "You are going to lose your info", preferredStyle: .alert)
        // action button when pressed user loses info about book
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        // cancel button when pressed allows user to keep book info and add/ delete as they please
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        // add buttons to alert controller
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        //present the controller
        self.present(alertController, animated: true, completion: nil)
    }
}
