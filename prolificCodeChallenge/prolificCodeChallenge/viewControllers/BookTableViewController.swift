//
//  BookTableViewController.swift
//  prolificCodeChallenge
//
//  Created by Karen Fuentes on 8/11/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController {
    var collectionOfBooks = [Book]() {
        didSet {
           self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Books"
        let addNavButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonWasTapped))
        self.navigationItem.leftBarButtonItem = addNavButton
        self.tableView.register(BookTableViewCell.self, forCellReuseIdentifier: "book cell")
        loadBooks()

    }
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    private func loadBooks() {
        BooksAPIClient.manager.getAllBooks(completionHandler: {
            self.collectionOfBooks = $0
        }) { (error) in
            print(error)
        }
    }

    @objc func addButtonWasTapped() {
        let navController = UINavigationController(rootViewController: AddBookViewController())
       self.navigationController?.present(navController, animated: true, completion: nil)
    }



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return collectionOfBooks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let bookCell = tableView.dequeueReusableCell(withIdentifier: "book cell", for: indexPath) as! BookTableViewCell
        bookCell.setupViews()
        let book = collectionOfBooks[indexPath.row]
        bookCell.bookTitleLabel.text = book.title
        bookCell.bookAuthorLabel.text = book.author
        return bookCell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
