//
//  ViewController.swift
//  SignInScreen
//
//  Created by Alexander Angelov on 17.01.23.
//

import UIKit

class MainPageViewController: UIViewController {
    
    private var appStorage = AppStorage()
    
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var greetingsLabel: UILabel!
    
    @IBAction func didPressSignOut(_ sender: UIButton) {
        let okAction = Alert.createAction(.ok { _ in
            self.signOut()
        })
        let cancenAction = Alert.createAction(.cancel)
        
        let alert = Alert.create(title: "Sign out?", message: "", actions: [okAction, cancenAction])
        present(alert, animated: true)
        
    }
    
    func signOut() {
        KeyChain.removePassword(service: "logInApp", account: "account1")
        appStorage.removeUser()
        appStorage.saveSignInStatus(value: false)
        
        if presentingViewController == nil {
            let signInVC = MainPageViewController.instantiate()
            signInVC.modalPresentationStyle = .fullScreen
            view.window?.rootViewController = signInVC
            view.window?.makeKeyAndVisible()
        } else {
            dismiss(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") else {
            return
        }
        greetingsLabel.text = "Welcome to the \(name), \(appStorage.getUsername())!"
    }
}

extension UIViewController {
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: VCIdentifiers.mainVC) as! Self
        return viewController
    }
}

class VCIdentifiers {
    
    static let mainVC = "MainPageVC"
    static let signInVC = "SignInPageVC"
}

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

