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
    }
    
    override func viewWillAppear(animated: Bool) {
        if mapView == nil{
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
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        mapView.showsUserLocation = false
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        mapView.delegate = nil
        mapView.removeFromSuperview()
        mapView = nil
        println("remove article map...")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
