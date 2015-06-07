//
//  MapViewController.swift
//  dywh
//
//  Created by lotusprize on 15/5/22.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit

class ArticleMapViewController: UIViewController,BMKMapViewDelegate {
    
    var mapView:BMKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = BMKMapView()
        mapView.frame = self.view.frame
        mapView.mapType = UInt(BMKMapTypeStandard)
        mapView.zoomLevel = 5
        mapView.showMapScaleBar = true
        mapView.mapScaleBarPosition = CGPointMake(10, 10)
        mapView.showsUserLocation = true
        
        mapView.compassPosition = CGPointMake(self.view.frame.width - 50, 10)
        mapView.setCenterCoordinate(CLLocationCoordinate2DMake(26.2038,109.8151), animated: true)
        self.view.addSubview(mapView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mapView.delegate = self
    }
     
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        mapView.delegate = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
