//
//  AlertOnlyOK.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/04/15.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit

final class AlertOnlyOK {
    static func show(controller: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnOK = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(btnOK)
        
        controller.present(alert, animated: true, completion: nil)
    }
}
