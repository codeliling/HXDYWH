//
//  MusicViewController.swift
//  dywh
//
//  Created by lotusprize on 15/5/22.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit

class VideoMapViewController: HXWHViewController {
    
    var mapViewController:MusicMapViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("music view did disappear")
        mapViewController?.view.removeFromSuperview()
        mapViewController = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

