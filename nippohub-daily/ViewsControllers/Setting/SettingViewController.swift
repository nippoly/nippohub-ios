//
//  SettingViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/04/27.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit

final class SettingViewController: UITableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        if index == 0 {
            let agreementsViewController = AgreementsViewController.instantiate()
            
            present(agreementsViewController, animated: true)
        } else if index == 1 {
            let privacyViewController = PrivacyViewController.instantiate()
            
            present(privacyViewController, animated: true)
        } else if index == 2 {
            if AccountRepository.instance.signOut() {
                let signInViewController = SignInViewController.instantiate()

                present(signInViewController, animated: true)
            }
        }
    }
    
    static func instantiate() -> SettingViewController {
        return UIStoryboard(name: "Setting", bundle: nil).instantiateInitialViewController() as! SettingViewController
    }
}
