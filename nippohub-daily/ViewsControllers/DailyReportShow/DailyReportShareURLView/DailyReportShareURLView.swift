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

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.loadView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.loadView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        subviews.forEach { [unowned self] in
            $0.frame = self.bounds
        }
    }

    @IBAction
    func tapStopShare() {
        onTapStopShare?.self()
    }

    private func loadView() {
        let nib = UINib(nibName: "DailyReportShareURLView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView

        view.frame = bounds

        addSubview(view)
    }
}
