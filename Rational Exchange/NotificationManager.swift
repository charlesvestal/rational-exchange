//
//  NotificationManager.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 10/18/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

class NotificationManager {
    private var observerTokens: [AnyObject] = []
    
    deinit {
        deregisterAll()
    }
    
    func deregisterAll() {
        for token in observerTokens {
            NSNotificationCenter.defaultCenter().removeObserver(token)
        }
        
        observerTokens = []
    }
    
    func registerObserver(name: String!, block: (NSNotification! -> ()?)) {
        let newToken = NSNotificationCenter.defaultCenter().addObserverForName(name, object: nil, queue: nil) {note in
            block(note)
            ()
        }
        
        observerTokens.append(newToken)
    }
    
    func registerObserver(name: String!, forObject object: AnyObject!, block: (NSNotification! -> ()?)) {
        let newToken = NSNotificationCenter.defaultCenter().addObserverForName(name, object: object, queue: nil) {note in
            block(note)
            ()
        }
        
        observerTokens.append(newToken)
    }
}
