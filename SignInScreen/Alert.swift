//
//  Alert.swift
//  SignInScreen
//
//  Created by Alexander Angelov on 25.01.23.
//

import UIKit

class Alert {
    enum Action {
        case confirmSignOut(style: UIAlertAction.Style = .default, _ handler: ((UIAlertAction) -> ())? = nil)
        case cancel
    }
    
    static func createAction(_ action: Action) -> UIAlertAction {
        switch action {
            case let .confirmSignOut(_, handler):
                return UIAlertAction(title: "Yes, sign out?", style: .destructive, handler: handler)
        case .cancel:
            return UIAlertAction(title: "Cancel", style: .cancel)
        }
    }
    
    static func create(title: String? = nil,
                       message: String? = nil,
                       preferredStyle: UIAlertController.Style = .alert,
                       actions: [UIAlertAction] = [createAction(.confirmSignOut())]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for action in actions {
            alert.addAction(action)
        }
        return alert
    }
}
