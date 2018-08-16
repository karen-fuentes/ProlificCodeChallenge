//
//  BookTableViewCell.swift
//  prolificCodeChallenge
//
//  Created by Karen Fuentes on 8/12/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit
// Class that contains the contents of a "Book Table view cell" positions labels and gives attributes to labels

class BookTableViewCell: UITableViewCell {
    
    // MARK: -  init methods
    
    //init method that sets up label constraints and assigns the reuse identifier
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(bookTitleLabel)
        self.contentView.addSubview(bookAuthorLabel)
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure constraints
    func configureConstraints() {
        bookTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        bookAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        let _ = [
            bookTitleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            bookTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            bookTitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            bookAuthorLabel.topAnchor.constraint(equalTo: bookTitleLabel.bottomAnchor, constant: 8),
            bookAuthorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            bookAuthorLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            bookAuthorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8)
            ].map({$0.isActive = true})
    }
    
    // MARK: - Lazy UI Object Variables
    lazy var bookTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var bookAuthorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "Avenir-Light", size: 16)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }() 
}
