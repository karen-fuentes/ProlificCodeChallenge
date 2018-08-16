//
//  BookTableViewController+Extension.swift
//  prolificCodeChallenge
//
//  Created by Karen Fuentes on 8/15/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit
//BookTableViewController data source method
extension BookTableViewController  {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionOfBooks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCell(withIdentifier: "book cell", for: indexPath) as! BookTableViewCell
        //switching of colors between every other cell
        let cellColor: UIColor = ((indexPath.row % 2) == 0) ? .lighterGray : .lightBlue
        let book = collectionOfBooks[indexPath.row]
        bookCell.bookTitleLabel.text = book.title
        bookCell.bookAuthorLabel.text = book.author
        bookCell.backgroundColor = cellColor
        return bookCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //segue to detail vc from selecting row at an index path
        let destinationVC = BookDetailViewController()
        destinationVC.book =  self.collectionOfBooks[indexPath.row]
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
