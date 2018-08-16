//
//  EditBookViewController.swift
//  prolificCodeChallenge
//
//  Created by Karen Fuentes on 8/16/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit

class EditBookViewController: UIViewController {
    //MARK: Properties
    var editView = AddBookView()
    var book: Book!
    var arrOfTxtField = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.editView
        //overwritting placeholder txt
        self.editView.titleTextField.placeholder = "title: \(self.book.title)"
        self.editView.authorTextField.placeholder = "author: \(self.book.author)"
        self.editView.publisherTextField.placeholder = "publisher: \(self.book.publisher)"
        self.editView.categoriesTextField.placeholder = "categories: \(self.book.categories)"
        //overwritting array with array of txtfield in view
        self.arrOfTxtField = [self.editView.titleTextField, self.editView.authorTextField, self.editView.publisherTextField, self.editView.categoriesTextField]
        //target action
        editView.submitButton.addTarget(self, action: #selector(makePutRequest), for: .touchUpInside)
    }
    
    // Function that takes in a textfield and depending on what the textfield
    // represents it sets that property for the book
    private func grabTextFieldValues(txtField: UITextField) {
        if txtField.text != "" {
            guard let txt = txtField.text else{return}
            switch txtField {
            case editView.titleTextField:
                self.book.title = txt
            case editView.authorTextField:
                self.book.author = txt
            case editView.publisherTextField:
                self.book.publisher = txt
            case editView.categoriesTextField:
                self.book.categories = txt
            default:
                print("error: Somehow you got to a textfield that does not exist here")
            }
        }
    }
    //makes put request based on user input
    //1. calls grabTxtFieldValue() and takes input from user
    //2. updates book properties
    //3. makes put request
    //4. alerts user and dismises the viewController
    @objc private func makePutRequest() {
        for txtField in arrOfTxtField {
            self.grabTextFieldValues(txtField: txtField)
        }
        BooksAPIClient.manager.editOrCreateBook(requestMethod: .put, book: self.book, completionHandler: { (response) in
            let alertController = UIAlertController(title: "The book Was edited Successfully!", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }, errorHandler: {print($0)})
    }
}
