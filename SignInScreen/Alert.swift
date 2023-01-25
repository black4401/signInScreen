//
//  Alert.swift
//  SignInScreen
//
//  Created by Alexander Angelov on 25.01.23.
//

import UIKit

class Alert {
    enum Action {
        case ok(style: UIAlertAction.Style = .default, _ handler: ((UIAlertAction) -> ())? = nil)
        case cancel
    }
    
    static func createAction(_ action: Action) -> UIAlertAction {
        switch action {
        case let .ok(style, handler):
            return UIAlertAction(title: "OK", style: style, handler: handler)
        case .cancel:
            return UIAlertAction(title: "Cancel", style: .cancel)
        }
    }
    
    static func create(title: String? = nil,
                       message: String? = nil,
                       preferredStyle: UIAlertController.Style = .alert,
                       actions: [UIAlertAction] = [createAction(.ok())]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for action in actions {
            alert.addAction(action)
        }
        return alert
    }
}
