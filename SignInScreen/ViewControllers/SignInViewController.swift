//
//  SignInViewController.swift
//  SignInScreen
//
//  Created by Alexander Angelov on 17.01.23.
//

import UIKit

class SignInViewController: UIViewController {
    #warning("Please group the class properties and methods for better readability")
    private let credentialValidator = CredentialsValidation()
    private var appStorage = AppStorage()
    
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var emailInvalidLabel: UILabel!
    @IBOutlet weak var passInvalidLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField?.delegate = self
        passwordField?.delegate = self
        hideErrorMessages()
        #warning("Consider extracting some of the logic here in a method or two")
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        usernameField.addTarget(self, action: #selector(textFieldAction)
                                , for: UIControl.Event.primaryActionTriggered)
        passwordField.addTarget(self, action: #selector(textFieldAction)
                                , for: UIControl.Event.primaryActionTriggered)
        
        usernameField.text = ""
        passwordField.text = ""
    }
    
    @objc func textFieldAction(textField: UITextField) {
        if usernameField.isFirstResponder {
            usernameField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        } else if passwordField.isFirstResponder {
            passwordField.resignFirstResponder()
            performSignIn()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideErrorMessages()
        #warning("You can create a method that changes both textfields text to empty string to not repeat code")
        usernameField.text = ""
        passwordField.text = ""
    }
    
    @IBAction func didPressLogIn(_ sender: Any) {
        performSignIn()
    }
    
    private func performSignIn() {
        hideErrorMessages()
        loginButton.isSelected = true
        
        guard let email = usernameField.text, let pass = passwordField.text else {
            return
        }
        
        let isEmailValid = credentialValidator.isValidEmail(email)
        let isPasswordValid = credentialValidator.isValidPassword(pass)
        
        if !isEmailValid {
            emailInvalidLabel.text = "Your email address is not valid."
        }
        if !isPasswordValid {
            passInvalidLabel.text = "Your password must be a minimum of 8 characters and must contain at least one special character."
        }
        
        if isEmailValid && isPasswordValid {
            let mainPageVC = MainPageViewController.instantiate()
            mainPageVC.modalPresentationStyle = .fullScreen
            present(mainPageVC, animated: true)
            
            KeyChain.savePassword(service: "logInApp", account: email, data: pass)
            AppStorage.saveUsername(value: email)
            AppStorage.saveSignInStatus(value: true)
        }
        loginButton.isSelected = false
    }
}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameField {
            emailInvalidLabel.text = ""
        } else if textField == passwordField {
            passInvalidLabel.text = ""
        }
    }
}

extension SignInViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    #warning("this method is not used outside of the class and can be private")
    func hideErrorMessages() {
        emailInvalidLabel.text = ""
        passInvalidLabel.text = ""
    }
}

