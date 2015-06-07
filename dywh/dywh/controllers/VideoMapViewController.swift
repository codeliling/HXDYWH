//
//  MusicViewController.swift
//  dywh
//
//  Created by lotusprize on 15/5/22.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit

class VideoMapViewController: HXWHViewController,BMKMapViewDelegate {
    
    var mapView:BMKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        mapView = BMKMapView()
        mapView.frame = self.view.frame
        mapView.mapType = UInt(BMKMapTypeStandard)
        mapView.zoomLevel = 5
        mapView.showMapScaleBar = true
        mapView.setCenterCoordinate(CLLocationCoordinate2DMake(109.815162,26.203805), animated: true)
        self.view.addSubview(mapView)
    }

    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("music view did disappear")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

