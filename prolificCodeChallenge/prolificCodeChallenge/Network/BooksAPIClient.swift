//
//  BooksAPIClient.swift
//  prolificCodeChallenge
//
//  Created by Karen Fuentes on 8/11/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//
import Foundation
//API Client that creates, edits, and deletes book
struct BooksAPIClient {
    private init() { }
    static let manager = BooksAPIClient()
    private let endpoint = "http://prolific-interview.herokuapp.com/5b6e0136eff04800097ca206/"
    
    // MARK: - GET Request (all books)
    func getAllBooks(completionHandler: @escaping ([Book]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let stringURL = endpoint + "books/"
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
    // MARK: GET Request w/ id
    func getBookWith(id: String, completionHandler: @escaping (Book) -> Void, errorHandler: @escaping (Error) -> Void) {
        
        let stringURL = endpoint + "books/\(id)/"
        guard let url = URL(string: stringURL) else {
            errorHandler(AppError.badURL(str: stringURL))
            return
        }
        let urlRequest = URLRequest(url: url)
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let book = try JSONDecoder().decode(Book.self, from: data)
                completionHandler(book)
            }
            catch {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        APIRequestManager.manager.performDataTask(with: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }
    
    
    // MARK: - POST Request
    func createBook(book: Book, completionHandler: @escaping (URLResponse) -> Void, errorHandler: @escaping (Error) -> Void) {
        let stringURL = endpoint + "books/"
        guard let url = URL(string: stringURL) else {
            errorHandler(AppError.badURL(str: stringURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let postString = "author=\(book.author)&categories=\(book.categories)&publisher=\(book.publisher)&title=\(book.title)"
        urlRequest.httpBody = postString.data(using: .utf8)
        
        APIRequestManager.manager.performDataTask(with: urlRequest, completionResponse: { (response) in
            completionHandler(response)
        }, errorHandler: { print($0) })
    }
    
    // MARK: - PUT Request
    func updateBook(book: Book, completionHandler: @escaping (URLResponse) -> Void, errorHandler: @escaping(Error) -> Void) {
        let stringURL = endpoint + "books/\(book.id)/"
        guard let url = URL(string: stringURL) else {
            errorHandler(AppError.badURL(str: stringURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let editedBook = Book(author: book.author, categories: book.categories, id: book.id, lastCheckedOut: nil, lastCheckedOutBy: book.lastCheckedOutBy, publisher: book.publisher, title: book.title, url: book.url)
        
        do {
            let encodedBody = try JSONEncoder().encode(editedBook)
            urlRequest.httpBody = encodedBody
            APIRequestManager.manager.performDataTask(with: urlRequest, completionResponse: { (response) in
                completionHandler(response)
            }, errorHandler: {print($0)})
            
        } catch let error {
            errorHandler(error)
        }
    }
    
    // MARK: - DELETE Request
    
    func delete(allBooks:Bool, book: Book?,
                completionHandler: @escaping (URLResponse) -> Void,
                errorHandler: @escaping (Error) -> Void) {
        
        var stringURL = endpoint
        
        if allBooks {
            stringURL += "clean"
        } else {stringURL += "books/\(book!.id)/"}
        
        guard let url = URL(string: stringURL) else {
            errorHandler(AppError.badURL(str: stringURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        
        APIRequestManager.manager.performDataTask(with: urlRequest, completionResponse: { (response) in
            completionHandler(response)
        }, errorHandler: { print($0) })
    }
}
