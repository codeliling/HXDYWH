//
//  ArticleDetailViewController.swift
//  dywh
//
//  Created by lotusprize on 15/5/22.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit
import Haneke

class ArticleDetailViewController: HXWHViewController,UIWebViewDelegate ,UIGestureRecognizerDelegate,UINavigationControllerDelegate,UMSocialUIDelegate{
    
    @IBOutlet weak var webView: UIWebView!
    
    var shareUrl:String!
    var articleModel:ArticleModel!
    let cache = Shared.imageCache
    var image:UIImage?
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        var rightButton:UIButton = UIButton(frame: CGRectMake(0, 0, 35, 35))
        rightButton.setImage(UIImage(named: "shareIconWhite"), forState: UIControlState.Normal)
        rightButton.addTarget(self, action: "shareBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
       
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView:rightButton)
        
        self.navigationController?.interactivePopGestureRecognizer.enabled = true
        webView.delegate = self
        
        let URL = NSURL(string: articleModel.articleImageUrl!)!
        let fetcher = NetworkFetcher<UIImage>(URL: URL)
        
        cache.fetch(fetcher: fetcher).onSuccess { image in
            // Do something with image
            self.image = image
        }
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
        shareUrl = ServerUrl.ServerArticleDetailURL + String(articleModel.articleId)
        webView.loadRequest(NSURLRequest(URL:NSURL(string: shareUrl)!))
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
   
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        activityIndicatorView.stopAnimating()
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityIndicatorView.hidden = false
        activityIndicatorView.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.hidden = true
    }
    
    func shareBtnClick(rightButton:UIButton){
        println("share content click")
       
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: "556a5c3e67e58e57a3003c8a", shareText: self.articleModel.articleName, shareImage: image, shareToSnsNames: [UMShareToQzone,UMShareToTencent,UMShareToQQ,UMShareToSms,UMShareToWechatFavorite,UMShareToWechatSession,UMShareToWechatTimeline], delegate: self)
        UMSocialData.defaultData().extConfig.wechatSessionData.url = self.shareUrl
        UMSocialData.defaultData().extConfig.wechatTimelineData.url = self.shareUrl
        UMSocialData.defaultData().extConfig.wechatFavoriteData.url = self.shareUrl
        UMSocialData.defaultData().extConfig.qqData.url = self.shareUrl
        UMSocialData.defaultData().extConfig.qzoneData.url = self.shareUrl
    }
    
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        println(response.responseCode)
    }
    
    func isDirectShareInIconActionSheet() -> Bool {
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        println("#######**********")
    }

    
}
