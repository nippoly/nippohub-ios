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
    
    @IBAction private func signUp() {
        let email = formEmail.text ?? ""
        let password = formPassword.text ?? ""
        let passwordConfirmation = formPasswordConfirmation.text ?? ""
        
        if password != passwordConfirmation {
            AlertOnlyOK.show(
                controller: self,
                title: NSLocalizedString("AuthFail.SignUp.Title", comment: ""),
                message: NSLocalizedString("AuthFail.SignUp.PasswordErrorDescription", comment: "")
            )

            return
        }
        
        AccountRepository.instance.signUp(email: email, password: password, onCompletion: { [unowned self] in
            let navigationController = UINavigationController()
            let viewController = DailyReportIndexViewController.instantiate()

            self.present(navigationController, animated: true)
            navigationController.pushViewController(viewController, animated: false)
        }, onFail: { [unowned self] err in
            let msg = err.localizedDescription

            if msg  == "The email address is already in use by another account." {
                AlertOnlyOK.show(
                    controller: self,
                    title: NSLocalizedString("AuthFail.SignUp.Title", comment: ""),
                    message: NSLocalizedString("AuthFail.SignUp.AlreadyUseEmailDescription", comment: "")
                )
            } else {
                AlertOnlyOK.show(
                    controller: self,
                    title: NSLocalizedString("AuthFail.SignUp.Title", comment: ""),
                    message: NSLocalizedString("AuthFail.SignUp.SomethingErrorDescriptione", comment: "")
                )
            }
        })
    }

    @IBAction private func transitToAgreements() {
        let viewController = AgreementsViewController.instantiate()

        present(viewController, animated: true)
    }

    @IBAction private func transitToPrivacy() {
        let viewController = PrivacyViewController.instantiate()

        present(viewController, animated: true)
    }
    
    static func instantiate() -> SignUpViewController {
        return UIStoryboard(name: "SignUp", bundle: nil).instantiateInitialViewController() as! SignUpViewController
    }
}
