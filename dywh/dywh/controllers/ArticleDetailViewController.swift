//
//  ArticleDetailViewController.swift
//  dywh
//
//  Created by lotusprize on 15/5/22.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit

class ArticleDetailViewController: HXWHViewController,UIWebViewDelegate ,UIGestureRecognizerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        var rightButton:UIButton = UIButton(frame: CGRectMake(0, 0, 35, 35))
        rightButton.setImage(UIImage(named: "shareIconWhite"), forState: UIControlState.Normal)
        rightButton.addTarget(self, action: "shareBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
       
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView:rightButton)
        
        self.navigationController?.interactivePopGestureRecognizer.enabled = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
    }
    
    func shareBtnClick(){
        println("share content click")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
