//
//  MapViewController.swift
//  dywh
//
//  Created by lotusprize on 15/5/22.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit
import Haneke

class ArticleMapViewController: UIViewController,BMKMapViewDelegate {
    
    let cache = Shared.imageCache
    
    var mapView:BMKMapView!
    var articleList:[ArticleModel] = []
    var mAPView:MapArticlePanelView!
    var articleModel:ArticleModel?
    
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
        
        mAPView = MapArticlePanelView(frame: CGRectMake(10, UIScreen.mainScreen().bounds.size.height - 300, UIScreen.mainScreen().bounds.size.width - 20, 130), title: "", articleDescription: "")
        mAPView.backgroundColor = UIColor.whiteColor()
        mAPView.alpha = 0.8
        mAPView.hidden = true
        mAPView.userInteractionEnabled = true
        var tapView:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "panelClick:")
        self.mAPView.addGestureRecognizer(tapView)
        self.view.addSubview(mAPView)
        
    }
    
    func mapView(mapView: BMKMapView!, didSelectAnnotationView view: BMKAnnotationView!) {
        var annotation:BMKPointAnnotation = view.annotation as! BMKPointAnnotation
        println(annotation.title)
    }
    
    func addMapPoint(articleModel:ArticleModel){
        var annotation:BMKPointAnnotation = BMKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(Double(articleModel.latitude), Double(articleModel.longitude));
        annotation.title = articleModel.articleName
        mapView.addAnnotation(annotation)
        articleList.append(articleModel)
    }
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if annotation.isKindOfClass(BMKPointAnnotation.classForCoder()) {
            var newAnnotationView:BMKPinAnnotationView = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: "articleAnnotation");
            newAnnotationView.pinColor = UInt(BMKPinAnnotationColorPurple)
            newAnnotationView.animatesDrop = true;// 设置该标注点动画显示
            newAnnotationView.annotation = annotation;
            newAnnotationView.image = UIImage(named: "locationIcon")
            
            return newAnnotationView
        }
        return nil
    }
    
    func mapView(mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
        var title:String = view.annotation.title!()
        
        for aModle in articleList{
            if title == aModle.articleName{
                articleModel = aModle
            }
        }
        
        if (articleModel != nil){
            mAPView.hidden = false
            self.loadImageByUrl(mAPView, url: articleModel!.articleImageUrl!)
            mAPView.title = articleModel!.articleName
            mAPView.articleDescription = articleModel!.articleDescription
            mAPView.setNeedsDisplay()
        }
    }
    
    func panelClick(gesture:UIGestureRecognizer){
        if articleModel != nil{
            var detailViewController:ArticleDetailViewController? = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ArticleDetail") as? ArticleDetailViewController
            detailViewController?.articleId = articleModel!.articleId
            self.navigationController?.pushViewController(detailViewController!, animated: true)
        }
    }
    
    func loadImageByUrl(view:MapArticlePanelView, url:String){
        let URL = NSURL(string: url)!
        let fetcher = NetworkFetcher<UIImage>(URL: URL)
        cache.fetch(fetcher: fetcher).onSuccess { image in
            // Do something with image
            view.imageLayer.contents = image.CGImage
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
    }
    
}
