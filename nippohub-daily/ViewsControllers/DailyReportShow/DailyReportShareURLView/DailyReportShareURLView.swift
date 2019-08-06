//
//  DailyReportShareUrlView.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/08/06.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit

class DailyReportShareURLView: UIView {
    @IBOutlet private weak var textFieldShareURL: UITextField!
    @IBOutlet private weak var buttonShareStop: UIButton!
    var shareURL: String = "" {
        didSet {
            textFieldShareURL.text = shareURL
        }
    }
    var onTapStopShare: (() -> ())?


    @IBAction
    func tapStopShare() {
        onTapStopShare?.self()
    }

    func loadView() {
        let view = Bundle.main.loadNibNamed("DailyReportShareURLView", owner: self, options: nil)?.first as? DailyReportShareURLView
    }
}
