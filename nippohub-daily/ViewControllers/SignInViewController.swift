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
        
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            
            // TODO: nilじゃない時の処理
            if error == nil {
                self.performSegue(withIdentifier: "signInToDailyReportsSegue", sender: nil)
            }
        }
    }

}

