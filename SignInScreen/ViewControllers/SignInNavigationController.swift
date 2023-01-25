//
//  SignInNavigationController.swift
//  SignInScreen
//
//  Created by Alexander Angelov on 22.01.23.
//

import UIKit

class SignInNavigationController: UINavigationController {
    
    //private let appStorage = AppStorage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppStorage.getSignInStatus() ? presentMainScreen() : presentSignIn()
        print("Logged in status: \(AppStorage.getSignInStatus())")
    }
    
    private func presentMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainScreenVC = storyboard.instantiateViewController(withIdentifier: "MainPageVC")
        viewControllers = [mainScreenVC]
    }
    
    private func presentSignIn() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInPageVC")
        viewControllers = [signInVC]
    }
    
}
