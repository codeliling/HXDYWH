//
//  MapViewController.swift
//  dywh
//
//  Created by lotusprize on 15/5/22.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit

class ArticleMapViewController: UIViewController,MAMapViewDelegate {
    
    var mapView:MAMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MAMapServices.sharedServices().apiKey = "bec03cfecbd28f824945ebd0243e316a"
        mapView = MAMapView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)))
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(MAUserTrackingModeFollow, animated: true)
        mapView.showsCompass = false
        mapView.showsScale = true
        mapView.scaleOrigin = CGPointMake(100, mapView.frame.size.height-20)
        mapView.delegate = self
        self.view.addSubview(mapView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
