//
//  NotificationViewController.swift
//  MarketMeltdown-Notification-Content
//
//  Created by Syed Aqib Aftab on 11/03/2019.
//  Copyright © 2019 Dopey Idea. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }
    
}

