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
        print("|---------------------------------------|")
        Auth.auth().signIn(withEmail: formEmail.text!, password: formPassword.text!) { user, error in
            print("-------------")
            print(user)
            print(error)
            print("-------------")
        }
    }

}

