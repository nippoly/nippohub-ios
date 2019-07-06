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
        
        AccountRepository.instance.signUp(email: email, password: password) { [unowned self] error in
            if error == nil {
                let navigationController = UINavigationController()
                let viewController = DailyReportIndexViewController.instantiate()

                self.present(navigationController, animated: true)
                navigationController.pushViewController(viewController, animated: false)
            } else {
                // TODO: 細かく分ける
                AlertOnlyOK.show(controller: self, title: "アカウント作成失敗", message: "アカウント作成できませんでした")
            }
        }
    }

    @IBAction func transitToAgreements() {
        let viewController = AgreementsViewController.instantiate()

        present(viewController, animated: true)
    }

    @IBAction func transitToPrivacy() {
        let viewController = PrivacyViewController.instantiate()

        present(viewController, animated: true)
    }
    
    static func instantiate() -> SignUpViewController {
        return UIStoryboard(name: "SignUp", bundle: nil).instantiateInitialViewController() as! SignUpViewController
    }
}
