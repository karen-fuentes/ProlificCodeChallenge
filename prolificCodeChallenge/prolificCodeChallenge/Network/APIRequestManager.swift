//
//  APIRequestManager.swift
//  prolificCodeChallenge
//
//  Created by Karen Fuentes on 8/11/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//
import Foundation

// MARK: Enum Error type
enum AppError: Error {
    case noData
    case noResponse
    case couldNotParseJSON(rawError: Error)
    case badURL(str: String)
    case urlError(rawError: URLError)
    case otherError(rawError: Error)
}

// MARK: - API Request Manager
//using singleton pattern
class APIRequestManager {
    
    private init() {}
    
    //Mark: -Properties
    static let manager = APIRequestManager()
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    
    /// gets data with given url and handles errors if they are encountered
    ///
    /// - Parameters:
    ///   - request: the type of url request.
    ///   - completion handler: after data arrive it runs the completion handler.
    ///   - errorHandler: returns an error if an error occurs.
    func performDataTask(with request: URLRequest, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        self.urlSession.dataTask(with: request){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {
                    errorHandler(AppError.noData)
                    return
                }
                
                if let error = error {
                    errorHandler(error)
                }
                completionHandler(data)
            }
            }.resume()
    }
}

