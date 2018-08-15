//
//  Defaults.swift
//  prolificCodeChallenge
//
//  Created by Karen Fuentes on 8/14/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import Foundation

struct Defaults {
    
    static let nameKey = "name"
    static let userSessionKey = "com.save.usersession"
    
    struct Model {
        var name: String?
        
        init(_ json: [String: String]) {
            self.name = json[nameKey]
            
        }
    }
    
    static var saveName = { (name: String) in
        UserDefaults.standard.set([nameKey: name], forKey: userSessionKey)
    }
    
    static var getName = { _ -> Model in
        return Model((UserDefaults.standard.value(forKey: userSessionKey) as? [String: String]) ?? [:])
    }(())
    
    static func clearUserData(){
        UserDefaults.standard.removeObject(forKey: userSessionKey)
    }
}
