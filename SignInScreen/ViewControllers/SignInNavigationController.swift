//
//  SignInNavigationController.swift
//  SignInScreen
//
//  Created by Alexander Angelov on 22.01.23.
//

import UIKit

class SignInNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppStorage.getSignInStatus() ? presentMainScreen() : presentSignIn()
        print("Logged in status: \(AppStorage.getSignInStatus())")
    }
}

private extension SignInNavigationController {
    func presentMainScreen() {
        let storyboard = UIStoryboard(name: StoryboardIdentifiers.main, bundle: nil)
        let mainScreenVC = storyboard.instantiateViewController(withIdentifier: VCIdentifiers.mainVC)
        viewControllers = [mainScreenVC]
    }
    
    func presentSignIn() {
        let storyboard = UIStoryboard(name: StoryboardIdentifiers.main, bundle: nil)
        let signInVC = storyboard.instantiateViewController(withIdentifier: VCIdentifiers.signInVC)
        viewControllers = [signInVC]
    }
}
