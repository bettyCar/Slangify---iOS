//
//  NotificationExtension.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 14/04/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import Foundation

enum ReachabilityStatus {
    case resumed
    case stopped
}

struct ReachabilityNotification {
    
    static let notificationName = "NotificationObserver"
    
    static func observeReachability(listener: Any, selector: Selector) {
        NotificationCenter.default.addObserver(listener, selector: selector, name: Notification.Name(notificationName), object: nil)
    }
    
    static func stopObservingReachbility(listener: Any) {
        NotificationCenter.default.removeObserver(listener, name: Notification.Name(notificationName), object: nil)
    }
    
    static func postReachabilityNotification(_ status: ReachabilityStatus) {
        NotificationCenter.default.post(name: Notification.Name(notificationName), object: status)
    }
}
