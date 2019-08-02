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
        
        AccountRepository.instance.signIn(email: email, password: password, onCompletion: { [unowned self] in
            let navigationController = UINavigationController()
            let viewController = DailyReportIndexViewController.instantiate()

            self.present(navigationController, animated: true)
            navigationController.pushViewController(viewController, animated: false)
        }, onFail: { [unowned self] _ in
            AlertOnlyOK.show(
                controller: self,
                title: NSLocalizedString("AuthFail.SignIn.Title", comment: ""),
                message: NSLocalizedString("AuthFail.SignIn.Description", comment: "")
            )
        })
    }

    @IBAction func transitToSignUp() {
        let viewController = SignUpViewController.instantiate()

        present(viewController, animated: true)
    }
    
    static func instantiate() -> SignInViewController {
        return UIStoryboard(name: "SignIn", bundle: nil).instantiateInitialViewController() as! SignInViewController
    }
}
