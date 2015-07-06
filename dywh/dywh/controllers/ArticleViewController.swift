//
//  ArticleViewController.swift
//  dywh
//
//  Created by lotusprize on 15/3/24.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit
import Alamofire
import Haneke

class ArticleViewController: HXWHViewController,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    var mapViewController:ArticleMapViewController?
    
    var imageWidth:CGFloat = 0.0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var listBtn: UIButton!
    
    @IBOutlet weak var mapBtn: UIButton!
    
    let cache = Shared.imageCache
    
    var articleList:[ArticleModel] = []
    
    @IBOutlet weak var activeIndicatorView: UIActivityIndicatorView!
    
    var currentPage:Int = 1
    let limit:Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
        collectionView.delegate = self
        //collectionView.alwaysBounceVertical = true
        
        listBtn.setBackgroundImage(UIImage(named: "btnSelected"), forState: UIControlState.Selected)
        listBtn.setBackgroundImage(UIImage(named: "btnNormal"), forState: UIControlState.Normal)
        mapBtn.setBackgroundImage(UIImage(named: "btnSelected"), forState: UIControlState.Selected)
        mapBtn.setBackgroundImage(UIImage(named: "btnNormal"), forState: UIControlState.Normal)
        listBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
        mapBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
        
        println(UIScreen.mainScreen().bounds.size.width)
        imageWidth = (UIScreen.mainScreen().bounds.size.width - 16) / 2
        println("width is \(imageWidth)")
                
        listBtn.selected = true
        mapBtn.selected = false
        
        collectionView.addPullToRefreshWithActionHandler{ () -> Void in
            self.loadingArticleDataList()
            self.currentPage++
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (mapViewController == nil){
            mapViewController = ArticleMapViewController()
            mapViewController?.view.frame = CGRectMake(0, collectionView.frame.origin.y,collectionView.frame.size.width, collectionView.frame.size.height)
            self.addChildViewController(mapViewController!)
            self.view.addSubview(mapViewController!.view)
            mapViewController!.view.hidden = true
            collectionView.triggerPullToRefresh()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var articleModel:ArticleModel = articleList[indexPath.row]
        
        var articleCell:UICollectionViewCell? = collectionView.dequeueReusableCellWithReuseIdentifier("Cell1", forIndexPath: indexPath) as? UICollectionViewCell
       
        if articleCell == nil{
            articleCell = UICollectionViewCell(frame: CGRectMake(0, 0, imageWidth, imageWidth - 30))
            var articleView:ArticleView = ArticleView(frame: CGRectMake(0, 0, imageWidth, imageWidth - 30), titleName: articleModel.articleName!, tagName:articleModel.articleTag!)
            articleView.imageLayer.contents = UIImage(named: "article_loading")?.CGImage
            self.loadImageByUrl(articleView, url: articleModel.articleImageUrl!)
            articleCell?.contentView.addSubview(articleView)
        }
        else{
            var isAddArticleView:Bool = false
            for view in articleCell!.subviews {
                
                if let v = view as? ArticleView{
                    isAddArticleView = true
                    self.loadImageByUrl(v, url: articleModel.articleImageUrl!)
                    v.titleLayer.string = articleModel.articleName
                    v.typeLayer.string = articleModel.articleTag
                    self.loadImageByUrl(v, url: articleModel.articleImageUrl!)
                }
            }
            if !isAddArticleView{
                var articleView:ArticleView = ArticleView(frame: CGRectMake(0, 0, imageWidth, imageWidth - 30), titleName: articleModel.articleName!, tagName:articleModel.articleTag!)
                articleView.imageLayer.contents = UIImage(named: "article_loading")?.CGImage
                articleCell?.contentView.addSubview(articleView)
                self.loadImageByUrl(articleView, url: articleModel.articleImageUrl!)
            }
        }
    
        /*
        for(var index = 0;index < articleCell.contentView.subviews.count; index++){
            let view = articleCell.contentView.subviews[index] as! UIView
            view.removeFromSuperview()
        }*/
        
        return articleCell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var articleModel:ArticleModel = articleList[indexPath.row]
        var detailViewController:ArticleDetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ArticleDetail") as! ArticleDetailViewController
        detailViewController.articleModel = articleModel
        self.navigationController?.pushViewController(detailViewController, animated: true)
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
    
    func loadImageByUrl(view:ArticleView, url:String){
        let URL = NSURL(string: url)!
        let fetcher = NetworkFetcher<UIImage>(URL: URL)
        cache.fetch(fetcher: fetcher).onSuccess { image in
            // Do something with image
            view.imageLayer.contents = image.CGImage
        }
    }
    
    func loadingArticleDataList(){
        activeIndicatorView.hidden = false
        activeIndicatorView.startAnimating()
        Alamofire.request(.GET, ServerUrl.ServerContentURL, parameters: ["content_type":"1","limit":limit,"offset":limit*(currentPage - 1)])
            .responseJSON { (req, res, json, error) in
                if(error != nil) {
                    NSLog("Error: \(error)")
                    println(req)
                    println(res)
                }
                else {
                    println(json)
                    var resultDict:NSDictionary? = json as? NSDictionary
                    var dataDict:NSDictionary? = resultDict?.objectForKey("data") as? NSDictionary
                    var success:Int = dataDict?.objectForKey("success") as! Int
                    var count:Int = dataDict?.objectForKey("count") as! Int
                    if success == 1{
                        var articles:NSArray = dataDict?.objectForKey("articles") as! NSArray
                        if (articles.count > 0){
                            var articleModel:ArticleModel?
                            for tempDict in articles{
                                articleModel = ArticleModel()
                                articleModel?.articleName = tempDict.objectForKey("title") as? String
                                var categoryDict:NSDictionary? = tempDict.objectForKey("category") as? NSDictionary
                                articleModel?.articleTag = categoryDict?.objectForKey("name") as? String
                                articleModel?.articleImageUrl = tempDict.objectForKey("profile") as? String
                                articleModel?.articleId = tempDict.objectForKey("id") as! Int
                                articleModel?.latitude = tempDict.objectForKey("latitude") as! CGFloat
                                articleModel?.longitude = tempDict.objectForKey("longitude") as! CGFloat
                                articleModel?.articleDescription = tempDict.objectForKey("description") as? String
                                self.articleList.insert(articleModel!, atIndex: 0)
                                self.mapViewController?.addMapPoint(articleModel!)
                            }
                            //self.mapViewController?.articleList = self.articleList
                            self.collectionView.reloadData()
                        }
                        else{
                            self.view.makeToast("无更多数据！")
                        }
                    }
                    else{
                        self.view.makeToast("获取数据失败！")
                    }
                }
                self.activeIndicatorView.hidden = true
                self.activeIndicatorView.stopAnimating()
                self.collectionView.pullToRefreshView.stopAnimating()
        }
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
