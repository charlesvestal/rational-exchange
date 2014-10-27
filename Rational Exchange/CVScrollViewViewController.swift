//
//  CVScrollViewViewController.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 10/8/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation


let userHasOnboardedKey = "user_has_onboarded"

class CVScrollViewViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        
        var userHasOnboardedAlready = false //NSUserDefaults.standardUserDefaults().boolForKey(userHasOnboardedKey);
        
        if (!userHasOnboardedAlready) {
            bump()
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotoTop", name: scrollTopKey, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotoBottom", name: scrollBottomKey, object: nil)

        }
    
    
    func bump ()
    {
     
        let startingPage:CGFloat = 1
        
        
        var bumpHeight = mainView.bounds.height - (mainView.bounds.height / 15)
        
        UIView.animateWithDuration(0.17, delay: 3.0, options: .Repeat | .Autoreverse | .AllowUserInteraction | .CurveEaseIn, animations: {
            UIView.setAnimationRepeatCount(2.5)
            self.scrollView.setContentOffset(CGPointMake(0, bumpHeight), animated: false)
            }, completion: { finished in
                UIView.animateWithDuration(0.17, delay: 0.0, options: .AllowUserInteraction | .CurveEaseInOut, animations: {
                    self.scrollView.setContentOffset(CGPointMake(0,(self.mainView.bounds.height * startingPage)), animated: false)
                    }, completion: nil)
                        
            }
                )
         NSUserDefaults.standardUserDefaults().setBool(true, forKey: userHasOnboardedKey)
    }
    



    func gotoTop() {
        println("scrollview top")
        scrollView.setContentOffset(CGPointMake(0,0), animated: true)

    }
    
    func gotoBottom() {
        let pageNumber:CGFloat = 2
        var thirdPageStart =
        CGPointMake(0,(mainView.bounds.height * pageNumber))
        
        scrollView.setContentOffset(thirdPageStart, animated: true)
        println("scrollview bottom")
    }
    
    
    
    func setupScrollView ()
    {
        let startingPage:CGFloat = 1

        self.automaticallyAdjustsScrollViewInsets = false
        
        var numberOfPages:CGFloat = CGFloat(scrollView.subviews.count) - 1
        
        scrollView.contentSize = CGSize(width: mainView.bounds.width, height: (mainView.bounds.height * (numberOfPages - 1)))
        
        scrollView.contentOffset = CGPointMake(0,(mainView.bounds.height * startingPage))
    }

}