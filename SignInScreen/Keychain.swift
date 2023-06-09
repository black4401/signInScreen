//
//  Keychain.swift
//  SignInScreen
//
//  Created by Alexander Angelov on 18.01.23.
//

import Foundation

class KeyChain {
    
    
    class func updatePassword(service: String, account: String, data: String) {
        guard let dataFromString = data.data(using: .utf8, allowLossyConversion: false) else {
            return
        }
        
        let status = SecItemUpdate(modifierQuery(service: service, account: account), [kSecValueData: dataFromString] as CFDictionary)
        checkError(status)
    }
    
    class func removePassword(service: String, account: String) {
        let status = SecItemDelete(modifierQuery(service: service, account: account))
        checkError(status)
    }
    
    class func savePassword(service: String, account: String, data: String) {
        guard let dataFromString = data.data(using: .utf8, allowLossyConversion: false) else {
            return
        }
        
        let keychainQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: service,
                                        kSecAttrAccount: account,
                                          kSecValueData: dataFromString]
        
        let status = SecItemAdd(keychainQuery as CFDictionary, nil)
        checkError(status)
    }
    
    class func loadPassword(service: String, account: String) -> String? {
        var dataTypeRef: CFTypeRef?

        let status = SecItemCopyMatching(modifierQuery(service: service, account: account), &dataTypeRef)

        if status == errSecSuccess, let retrievedData = dataTypeRef as? Data {
            return String(data: retrievedData, encoding: .utf8)
        } else {
            checkError(status)
            return nil
        }
    }
    
    fileprivate static func modifierQuery(service: String, account: String) -> CFDictionary {
        let keychainQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: service,
                                        kSecAttrAccount: account,
                                         kSecReturnData: kCFBooleanTrue ?? false]
        
        return keychainQuery as CFDictionary
    }
    
    fileprivate static func checkError(_ status: OSStatus) {
        if status != errSecSuccess {
            if let errorMessage = SecCopyErrorMessageString(status, nil) {
                print("Operation failed: \(errorMessage)")
            }
        }
    }
}

