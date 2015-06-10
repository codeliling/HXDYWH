//
//  MusicViewController.swift
//  dywh
//
//  Created by lotusprize on 15/5/22.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit
import MediaPlayer

class VideoMapViewController: HXWHViewController,BMKMapViewDelegate {
    
    var mapView:BMKMapView!
    var videoList:[VideoModel] = []
    var videoModel:VideoModel?
    var mp:MPMoviePlayerViewController!
    var player:MPMoviePlayerController!
    
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
        mapView.delegate = self
        self.view.addSubview(mapView)

    }
    
    func mapView(mapView: BMKMapView!, didSelectAnnotationView view: BMKAnnotationView!) {
        var annotation:BMKPointAnnotation = view.annotation as! BMKPointAnnotation
        println("*********:\(annotation.title)")
        
    }
    
    func addMapPoint(videoModel:VideoModel){
        var annotation:BMKPointAnnotation = BMKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(Double(videoModel.latitude), Double(videoModel.longitude));
        annotation.title = videoModel.videoName
        
        mapView.addAnnotation(annotation)
        videoList.append(videoModel)
    }
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if annotation.isKindOfClass(BMKPointAnnotation.classForCoder()) {
            var newAnnotationView:BMKPinAnnotationView = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: "articleAnnotation");
            newAnnotationView.pinColor = UInt(BMKPinAnnotationColorPurple)
            newAnnotationView.animatesDrop = true;// 设置该标注点动画显示
            newAnnotationView.annotation = annotation;
            newAnnotationView.image = UIImage(named: "locationIcon")
            newAnnotationView.frame = CGRectMake(newAnnotationView.frame.origin.x, newAnnotationView.frame.origin.y, 30, 30)
            var bubbleView:VideoBubbleView = VideoBubbleView(frame:CGRectMake(0, 0, 130, 40), title: annotation.title!())
            bubbleView.backgroundColor = UIColor.whiteColor()
            bubbleView.layer.borderColor = UIColor.grayColor().CGColor
            bubbleView.layer.borderWidth = 1.0
            var pView:BMKActionPaopaoView = BMKActionPaopaoView(customView: bubbleView)
            newAnnotationView.paopaoView = pView
            return newAnnotationView
        }
        return nil
    }
    
    func mapView(mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
         
        var title:String = view.annotation.title!()
        
        for vModle in videoList{
            if title == vModle.videoName{
                videoModel = vModle
            }
        }
        
        if videoModel != nil{
            mp = MPMoviePlayerViewController(contentURL: NSURL(string:videoModel!.videoFileUrl!))
            mp.view.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 500, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.width)
            mp.view.center = CGPointMake(UIScreen.mainScreen().bounds.size.width/2, UIScreen.mainScreen().bounds.size.height/2)
            
            player = mp.moviePlayer
            player.shouldAutoplay = true;
            player.controlStyle = MPMovieControlStyle.Fullscreen;
            player.scalingMode = MPMovieScalingMode.AspectFill;
            player.play()
            self.view.addSubview(mp.view)
        }
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
        // Dispose of any resources that can be recreated.
    }
}

