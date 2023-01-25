//
//  SignInViewController.swift
//  SignInScreen
//
//  Created by Alexander Angelov on 17.01.23.
//

import UIKit

class SignInViewController: UIViewController {
    
    private let credentialValidator = CredentialsValidation()
    private var appStorage = AppStorage()
    
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var emailInvalidLabel: UILabel!
    @IBOutlet weak var passInvalidLabel: UILabel!
    
    @IBOutlet weak var viewYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        usernameField?.delegate = self
        passwordField?.delegate = self
        hideErrorMessages()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        usernameField.addTarget(self, action: #selector(MyTextFielAction)
                                , for: UIControl.Event.primaryActionTriggered)
        passwordField.addTarget(self, action: #selector(MyTextFielAction)
                                , for: UIControl.Event.primaryActionTriggered)
        
        usernameField.text = ""
        passwordField.text = ""
    }
    
    @objc func MyTextFielAction(textField: UITextField) {
        if usernameField.isFirstResponder {
            usernameField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        } else if passwordField.isFirstResponder {
            passwordField.resignFirstResponder()
            performSignIn()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideErrorMessages()
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
            appStorage.saveUsername(value: email)
            appStorage.saveSignInStatus(value: true)
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
    func hideErrorMessages() {
        emailInvalidLabel.text = ""
        passInvalidLabel.text = ""
    }
}

extension SignInViewController {
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        run(after: delay, closure: closure)
    }
    
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
}
