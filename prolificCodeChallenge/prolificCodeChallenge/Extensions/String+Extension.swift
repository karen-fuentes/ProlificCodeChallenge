//
//  String+Extension.swift
//  prolificCodeChallenge
//
//  Created by Karen Fuentes on 8/15/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import Foundation

extension String {

    func dateStringToReadableString() -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        let date = dateFormatter.date(from: self + " GMT")

        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, yyyy   h:mma"

        if let date = date {
            return newFormatter.string(from: date)
        } else {
            return "Date Error"
        }
    }
}

