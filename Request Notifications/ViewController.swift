//
//  ViewController.swift
//  Request Notifications
//
//  Created by   admin on 11/06/20.
//  Copyright © 2020 Evgeny Ezub. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let notifications = Notifications()
    @IBAction func btn1(_ sender: Any) {
        notifications.scheduleNotification(notificationType: "Local")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

