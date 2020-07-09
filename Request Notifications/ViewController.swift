//
//  ViewController.swift
//  Request Notifications
//
//  Created by   admin on 11/06/20.
//  Copyright © 2020 Evgeny Ezub. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countDownLabel: UILabel!
    
    var runCount = 5
    let notifications = Notifications()
    
    @IBAction func btn1(_ sender: Any) {
       Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        countDownLabel.text = ""
        countDownLabel.isHidden = false
        notifications.scheduleNotification(notificationType: "Local")
    }
    
    @objc func fireTimer(timer: Timer) {
        runCount -= 1
        countDownLabel.text = "\(runCount)"
        if runCount == 0 {
            timer.invalidate()
            countDownLabel.isHidden = true
            runCount = 5
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countDownLabel.text = ""
        countDownLabel.isHidden = true
        
    }


}

