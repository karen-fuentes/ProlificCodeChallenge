//
//  BooksAPIClient.swift
//  prolificCodeChallenge
//
//  Created by Karen Fuentes on 8/11/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//
import Foundation
struct BooksAPIClient {
    private init() { }
    static let manager = BooksAPIClient()
    
    // MARK: - GET Request (all books)
    func getAllBooks(completionHandler: @escaping ([Book]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let stringURL = "http://prolific-interview.herokuapp.com/5b6e0136eff04800097ca206/books"
        guard let url = URL(string: stringURL) else {
            errorHandler(AppError.badURL(str: stringURL))
            return
        }
        let urlRequest = URLRequest(url: url)
        var arrayOfBooks = [Book]()
        
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let books = try JSONDecoder().decode([Book].self, from: data)
                for book in books {
                    arrayOfBooks.append(book)
                }
                completionHandler(arrayOfBooks)
            }
            catch {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        APIRequestManager.manager.performDataTask(with: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }
}
