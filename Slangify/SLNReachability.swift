//
//  SLNReachability.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 14/04/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import Foundation
import ReachabilitySwift

protocol SLNReachabilityProtocol : class {
    func reachabilityStopped()
    func reachabilityResumed()
}

class SLNReachability : NSObject {
    
    let reachability = Reachability()!
    weak var delegate : SLNReachabilityProtocol?
    
    init(delegate: SLNReachabilityProtocol) {
        self.delegate = delegate
        super.init()
        checkRechability()
    }

    deinit {
        reachability.stopNotifier()
    }
    
    private func checkRechability() {
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            if let delegate = self.delegate {
                delegate.reachabilityResumed()
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                if let delegate = self.delegate {
                    delegate.reachabilityStopped()
                }
            }
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
