//
//  SignInViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/03/22.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit

final class SignInViewController: UIViewController {
    @IBOutlet private weak var formEmail: UITextField!
    @IBOutlet private weak var formPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction
    func signIn() {
        let email = formEmail.text ?? ""
        let password = formPassword.text ?? ""
        
        AccountRepository.instance.signIn(email: email, password: password) { [unowned self] error in
            if error == nil {
                let navigationController = UINavigationController()
                let viewController = DailyReportIndexViewController.instantiate()

                self.present(navigationController, animated: true)
                navigationController.pushViewController(viewController, animated: false)
            } else {
                // TODO: ネットワークエラーの時の文言
                AlertOnlyOK.show(controller: self, title: "サインイン失敗", message: "メールアドレスとパスワードが一致しません")
            }
        }
    }

    @IBAction func transitToSignUp() {
        let viewController = SignUpViewController.instantiate()

        present(viewController, animated: true)
    }
    
    static func instantiate() -> SignInViewController {
        return UIStoryboard(name: "SignIn", bundle: nil).instantiateInitialViewController() as! SignInViewController
    }
}
