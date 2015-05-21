//
//  ArticleViewController.swift
//  dywh
//
//  Created by lotusprize on 15/3/24.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit
import Alamofire

class ArticleViewController: UIViewController, MAMapViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    var mapView:MAMapView!
    var imageWidth:CGFloat = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var listBtn: UIButton!
    
    @IBOutlet weak var mapBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var attributes:[NSObject:AnyObject] = [NSForegroundColorAttributeName:UIColor(red:1.0, green: 1.0, blue: 1.0, alpha: 1)]
        if let font = UIFont(name: "Helvetica-Bold", size: 20) {
            attributes[NSFontAttributeName] = font
        }

        self.navigationController?.navigationBar.titleTextAttributes = attributes;
        
        // Do any additional setup after loading the view.
        MAMapServices.sharedServices().apiKey = "bec03cfecbd28f824945ebd0243e316a";
        mapView = MAMapView(frame: CGRectMake(0, 65, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-65))
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(MAUserTrackingModeFollow, animated: true)
        mapView.showsCompass = false
        mapView.showsScale = true
        mapView.scaleOrigin = CGPointMake(100, mapView.frame.size.height-20)
        mapView.delegate = self
        self.view.addSubview(mapView)
        mapView.hidden = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        println(UIScreen.mainScreen().bounds.size.width)
        imageWidth = (UIScreen.mainScreen().bounds.size.width - 10) / 2
        println("width is \(imageWidth)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var articleCell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell1", forIndexPath: indexPath) as UICollectionViewCell
       
        //articleCell.frame.size = CGSizeMake(imageWidth, imageWidth)
        
        var articleView:ArticleView = ArticleView(frame: CGRectMake(0, 0, imageWidth, imageWidth), imageName: "articleImage", titleName: "测试")
        
        for(var index = 0;index < articleCell.contentView.subviews.count; index++){
            let view = articleCell.contentView.subviews[index] as UIView
            view.removeFromSuperview()
        }
        articleCell.contentView.addSubview(articleView)
        return articleCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
       return 5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
