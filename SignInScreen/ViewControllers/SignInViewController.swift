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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField?.delegate = self
        passwordField?.delegate = self
        
        addTapGesture()
        
        addTargetForPrimaryKeyboardAction(to: usernameField)
        addTargetForPrimaryKeyboardAction(to: passwordField)
        
        hideErrorMessages()
        setFieldToEmpty(textField: usernameField)
        setFieldToEmpty(textField: passwordField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideErrorMessages()
        
        setFieldToEmpty(textField: usernameField)
        setFieldToEmpty(textField: passwordField)
    }
    
    @IBAction private func didPressLogIn(_ sender: Any) {
        performSignIn()
    }
    
    @objc private func didPressKeyboardPrimaryAction() {
        if usernameField.isFirstResponder {
            usernameField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        } else if passwordField.isFirstResponder {
            passwordField.resignFirstResponder()
            performSignIn()
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

private extension SignInViewController {
    func setFieldToEmpty(textField: UITextField) {
        textField.text = ""
    }
    
    func hideErrorMessages() {
        emailInvalidLabel.text = ""
        passInvalidLabel.text = ""
    }
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func addTargetForPrimaryKeyboardAction(to textField: UITextField) {
        textField.addTarget(self, action: #selector(didPressKeyboardPrimaryAction), for: UIControl.Event.primaryActionTriggered)
    }
    
    func performSignIn() {
        hideErrorMessages()
        loginButton.isSelected = true
        
        guard let email = usernameField.text, let pass = passwordField.text else {
            return
        }
        
        let isEmailValid = credentialValidator.isValidEmail(email)
        let isPasswordValid = credentialValidator.isValidPassword(pass)
        
        if !isEmailValid {
            emailInvalidLabel.text = "The email address you entered is not valid."
        }
        
        if !isPasswordValid {
            passInvalidLabel.text = "The password must be a minimum of 8 characters and must contain at least one special character."
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
