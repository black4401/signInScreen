//
//  ViewController.swift
//  SignInScreen
//
//  Created by Alexander Angelov on 17.01.23.
//

import UIKit

class MainPageViewController: UIViewController {
#warning("Please remove commented code if its not needed")
    //private var appStorage = AppStorage()
    
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var greetingsLabel: UILabel!
    
    @IBAction func didPressSignOut(_ sender: UIButton) {
        let okAction = Alert.createAction(.ok { _ in
            self.signOut()
        })
        let cancenAction = Alert.createAction(.cancel)
        #warning("Consider changing the alert title here to something more descriptive like Do you want to Sign out?")
        let alert = Alert.create(title: "Sign out?", message: "", actions: [okAction, cancenAction])
        present(alert, animated: true)
        
    }
    
   private func signOut() {
       #warning("Please format the code in this method, you can use this shortcut Ctrl + i after selecting")
       KeyChain.removePassword(service: "logInApp", account: AppStorage.getUsername())
        AppStorage.removeUser()
       AppStorage.saveSignInStatus(value: false)
        
        if presentingViewController == nil {
            self.presentSignInVC()
        } else {
            dismiss(animated: true)
        }
    }
    
    private func presentSignInVC() {
        if let signInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: VCIdentifiers.signInVC) as? SignInViewController {
            signInVC.modalPresentationStyle = .fullScreen
            present(signInVC, animated: true)
        }
    }
    #warning("The life cycle methods are usually placed after the vars and IBOutlets")
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") else {
            return
        }
        greetingsLabel.text = "Welcome to the \(name), \(AppStorage.getUsername())!"
    }
}
