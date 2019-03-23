//
//  SignInViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/03/22.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet var formEmail: UITextField!
    @IBOutlet var formPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction
    func signIn() {
        let email = formEmail.text!
        let password = formPassword.text!
        print("|---------------------------------------|")
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            // TODO: 実装
            print("-------------")
            print(user)
            print(error)
            print("-------------")
        }
    }

}

