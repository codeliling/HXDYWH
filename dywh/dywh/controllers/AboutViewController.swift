//
//  AboutViewController.swift
//  dywh
//
//  Created by lotusprize on 15/6/24.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import Foundation

class AboutViewController: HXWHViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        textView.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
}