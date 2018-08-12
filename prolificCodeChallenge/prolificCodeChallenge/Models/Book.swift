//
//  Book.swift
//  prolificCodeChallenge
//
//  Created by Karen Fuentes on 8/11/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import Foundation

struct Book: Codable {
    var author: String
    var categories: String
    var id: Int
    var lastCheckedOut: String?
    var lastCheckedOutBy: String?
    var publisher: String
    var title: String
    var url: String
}
