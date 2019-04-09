//
//  SignInViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/03/22.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet private weak var formEmail: UITextField!
    @IBOutlet private weak var formPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction
    func signIn() {
        let email = formEmail.text!
        let password = formPassword.text!
        
        AccountManager.manager.signIn(email: email, password: password) { _, error in
            
            // TODO: nilじゃない時の処理
            if error == nil {
                self.performSegue(withIdentifier: "signInToDailyReportsSegue", sender: nil)
            }
        }
    }

}

