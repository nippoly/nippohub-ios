//
//  SignUpViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/03/24.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit

final class SignUpViewController: UIViewController {
    @IBOutlet private weak var formEmail: UITextField!
    @IBOutlet private weak var formPassword: UITextField!
    @IBOutlet private weak var formPasswordConfirmation: UITextField!
    
    @IBAction
    func signUp() {
        let email = formEmail.text!
        let password = formPassword.text!
        let passwordConfirmation = formPasswordConfirmation.text!
        
        if password != passwordConfirmation {
            AlertOnlyOK.show(controller: self, title: "パスワードの不一致", message: "入力されたパスワードが一致していません")
        }
        
        AccountManager.instance.signUp(email: email, password: password) { [unowned self] _, error in
            if error == nil {
                self.performSegue(withIdentifier: "signUpToDailyReportsSegue", sender: nil)
            } else {
                // TODO: 細かく分ける
                AlertOnlyOK.show(controller: self, title: "アカウント作成失敗", message: "アカウント作成できませんでした")
            }
        }
    }
}
