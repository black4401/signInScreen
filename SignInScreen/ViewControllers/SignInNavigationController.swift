//
//  SignInNavigationController.swift
//  SignInScreen
//
//  Created by Alexander Angelov on 22.01.23.
//

import UIKit

class SignInNavigationController: UINavigationController {
#warning("Please group the class properties and methods for better readability")
    
    #warning("Please remove commented code if its not needed")
    //private let appStorage = AppStorage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppStorage.getSignInStatus() ? presentMainScreen() : presentSignIn()
        print("Logged in status: \(AppStorage.getSignInStatus())")
    }
    #warning("Consider grouping private methods in a private extension")
    #warning("Please extract hardcoded values in constants")
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
