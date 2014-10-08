//
//  ScrollViewViewController.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 10/8/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

class CVScrollViewViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
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