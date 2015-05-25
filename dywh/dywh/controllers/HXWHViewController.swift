//
//  HXWHViewController.swift
//  dywh
//
//  Created by lotusprize on 15/5/22.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit

class HXWHViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var attributes:[NSObject:AnyObject] = [NSForegroundColorAttributeName:UIColor(red:1.0, green: 1.0, blue: 1.0, alpha: 1)]
        if let font = UIFont(name: "Helvetica-Bold", size: 20) {
            attributes[NSFontAttributeName] = font
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = attributes;
    }
    
}
