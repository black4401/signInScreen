//
//  AppStorage.swift
//  SignInScreen
//
//  Created by Alexander Angelov on 19.01.23.
//

import Foundation

class AppStorage {
    
    static let userDefaults: UserDefaults = .standard
    
    static func saveUsername(value: String) {
        userDefaults.set(value, forKey: "username")
    }
    
    static func saveSignInStatus(value: Bool) {
        userDefaults.set(value, forKey: "isLoggedIn")
    }
    
    static func getSignInStatus() -> Bool {
        
        return userDefaults.bool(forKey: "isLoggedIn")
    }
    
    static func removeUser() {
        userDefaults.removeObject(forKey: "username")
    }
    
    static func getUsername() -> String {
        guard let username = userDefaults.value(forKey: "username") as? String else {
            return "Unable to get username"
        }
        
        guard let index = username.firstIndex(of: "@") else {
            return "Unable to get username"
        }
        return String(username.prefix(upTo: index))
    }
}
