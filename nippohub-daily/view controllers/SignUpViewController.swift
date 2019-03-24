//
//  SignUpViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/03/24.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet var formEmail: UITextField!
    @IBOutlet var formPassword: UITextField!
    @IBOutlet var formPasswordConfirmation: UITextField!
    
    @IBAction
    func signUp() {
        let email = formEmail.text!
        let password = formPassword.text!
        let passwordConfirmation = formPasswordConfirmation.text!
        
        if password != passwordConfirmation {
            // TODO: アラート入れる
            print("パスワードが異なります")
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            // TODO: nilじゃない時の処理
            if error == nil {
                self.performSegue(withIdentifier: "signUpToDailyReportsSegue", sender: nil)
            }
        }
    }
}
