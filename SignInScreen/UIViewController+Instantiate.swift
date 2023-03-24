//
//  UIViewController+Instantiate.swift
//  SignInScreen
//
//  Created by Alexander Angelov on 25.01.23.
//

import UIKit

extension UIViewController {
    #warning("Please extract the storyboard name in a constant as it is possible when this project expands to have more storyboards")
    static func instantiate() -> Self {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: VCIdentifiers.mainVC) as! Self
        return viewController
    }
}
