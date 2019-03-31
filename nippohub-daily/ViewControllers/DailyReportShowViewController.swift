//
//  DailyReportShowViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/03/29.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit

class DailyReportShowViewController: UIViewController {
    var dailyReport: DailyReport!
    
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelContent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = dailyReport.title // TODO: date追加
        labelContent.text = dailyReport.content
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dailyReportShowToDailyReportEditSegue" {
            let destController = segue.destination as! DailyReportEditViewController
            
            destController.dailyReport = self.dailyReport
        }
    }
}
