//
//  CredentialsValidation.swift
//  SignInScreen
//
//  Created by Alexander Angelov on 17.01.23.
//

import Foundation

class CredentialsValidation {
    
     let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
     let usernameRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
     let predicateFormat = "SELF MATCHES %@"
    
    func isValidPassword(_ password: String) -> Bool {
        let passPredicate = NSPredicate(format: predicateFormat, passwordRegex )
        return passPredicate.evaluate(with: password)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailPred = NSPredicate(format: predicateFormat, usernameRegex)
        return emailPred.evaluate(with: email)
    }
    
}

enum ValidationErrors {
    
    case email
    case password
    
    var message: String {
        switch self {
            case .email:
                #warning("A more descriptive message might be better here, for example The email address you entered ... and as a warning message it is good to end with !")
                return "Your email address is not valid."
            case .password:
                return "Your password must be a minimum of 8 characters and must contain at least one special character."
        }
    }
}


