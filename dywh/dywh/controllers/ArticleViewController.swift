//
//  ArticleViewController.swift
//  dywh
//
//  Created by lotusprize on 15/3/24.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit
import Alamofire

class ArticleViewController: HXWHViewController,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    var mapViewController:ArticleMapViewController?
    
    var imageWidth:CGFloat = 0.0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var listBtn: UIButton!
    
    @IBOutlet weak var mapBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        listBtn.setBackgroundImage(UIImage(named: "btnSelected"), forState: UIControlState.Selected)
        listBtn.setBackgroundImage(UIImage(named: "btnNormal"), forState: UIControlState.Normal)
        mapBtn.setBackgroundImage(UIImage(named: "btnSelected"), forState: UIControlState.Selected)
        mapBtn.setBackgroundImage(UIImage(named: "btnNormal"), forState: UIControlState.Normal)
        listBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
        mapBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
        
        println(UIScreen.mainScreen().bounds.size.width)
        imageWidth = (UIScreen.mainScreen().bounds.size.width - 16) / 2
        println("width is \(imageWidth)")
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (mapViewController == nil){
            mapViewController = ArticleMapViewController()
            mapViewController?.view.frame = CGRectMake(0, collectionView.frame.origin.y,collectionView.frame.size.width, collectionView.frame.size.height)
            mapViewController!.view.backgroundColor = UIColor.redColor()
            self.addChildViewController(mapViewController!)
            self.view.addSubview(mapViewController!.view)
            mapViewController!.view.hidden = true
        }
        listBtn.selected = true
        mapBtn.selected = false
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
        
        var articleCell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell1", forIndexPath: indexPath) as! UICollectionViewCell
       
        //articleCell.frame.size = CGSizeMake(imageWidth, imageWidth)
        
        var articleView:ArticleView = ArticleView(frame: CGRectMake(0, 0, imageWidth, imageWidth - 30), imageName: "articleImage", titleName: "测试", tagName:"风景")
        
        for(var index = 0;index < articleCell.contentView.subviews.count; index++){
            let view = articleCell.contentView.subviews[index] as! UIView
            view.removeFromSuperview()
        }
        articleCell.contentView.addSubview(articleView)
        articleCell.frame.size = CGSizeMake(imageWidth, imageWidth - 30)
        return articleCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(imageWidth, imageWidth - 30);
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 5, 0, 5);//上 左 下 右
    }
    
    @IBAction func ArticleListBtnClick(sender: UIButton) {
        mapViewController!.view.hidden = true
        sender.selected = true
        mapBtn.selected = false
    }
    
    @IBAction func MapBtnClick(sender: UIButton) {
        mapViewController!.view.hidden = false
        sender.selected = true
        listBtn.selected = false
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
       return 5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("article view did disappear")
        //mapViewController?.removeFromParentViewController()
        //mapViewController?.view.removeFromSuperview()
        //mapViewController = nil
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
