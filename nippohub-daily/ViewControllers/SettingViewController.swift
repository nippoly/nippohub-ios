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
        let storyBoard = self.storyboard!
        
        if index == 0 {
            let agreementsViewController = storyBoard.instantiateViewController(withIdentifier: "AgreementsViewController")
            
            self.present(agreementsViewController, animated: true, completion: nil)
        } else if index == 1 {
            let privacyViewController = storyBoard.instantiateViewController(withIdentifier: "PrivacyViewController")
            
            self.present(privacyViewController, animated: true, completion: nil)
        } else if index == 2 {
            let signInViewController = storyBoard.instantiateViewController(withIdentifier: "SignInViewController")
            
            if AccountRepository.instance.signOut() {
                self.present(signInViewController, animated: true, completion: nil)
            }
        }
    }
}
