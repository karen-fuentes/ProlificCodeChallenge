//
//  BookTableViewCell.swift
//  prolificCodeChallenge
//
//  Created by Karen Fuentes on 8/12/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    func setupViews() {
        self.backgroundColor = UIColor.clear
        layer.cornerRadius = 5
        layer.masksToBounds = true
        setupStack()
    }
    
    private func setupStack() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
        
        stackView.addArrangedSubview(bookTitleLabel)
        NSLayoutConstraint.activate([
            bookTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            bookTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15)])
        
        stackView.addArrangedSubview(bookAuthorLabel)
        NSLayoutConstraint.activate([
            bookAuthorLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            bookAuthorLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15)])
    }
    
    lazy var  bookTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 2
        lbl.textColor = UIColor.black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    lazy var bookAuthorLabel : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 2
        lbl.textColor = UIColor.black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var stackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis  = UILayoutConstraintAxis.vertical
        stView.distribution  = UIStackViewDistribution.fillEqually
        stView.alignment = UIStackViewAlignment.center
        stView.spacing = 2.0
        return stView
    }()
}


