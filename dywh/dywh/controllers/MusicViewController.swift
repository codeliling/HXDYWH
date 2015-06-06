//
//  MusicViewController.swift
//  dywh
//
//  Created by lotusprize on 15/5/22.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit
import Alamofire
import Haneke

class MusicViewController: HXWHViewController {
    
     var mapViewController:MusicMapViewController?
    let cache = Shared.imageCache
    
    @IBOutlet weak var listBtn: UIButton!
    
    @IBOutlet weak var mapBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var musicView: UIView!
    
    var cyclePlayBtn:UIButton!
    var shareBtn:UIButton!
    var prePlayBtn:UIButton!
    var nextPlayBtn:UIButton!
    
    var musicNameLayer:CATextLayer!
    var authorNameLayer:CATextLayer!
    
    var musicName:String?
    var musicAuthorName:String?
    var cdView:UIImageView!
    
    @IBOutlet weak var musicProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listBtn.setBackgroundImage(UIImage(named: "btnSelected"), forState: UIControlState.Selected)
        listBtn.setBackgroundImage(UIImage(named: "btnNormal"), forState: UIControlState.Normal)
        mapBtn.setBackgroundImage(UIImage(named: "btnSelected"), forState: UIControlState.Selected)
        mapBtn.setBackgroundImage(UIImage(named: "btnNormal"), forState: UIControlState.Normal)
        listBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
        mapBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
        
        musicView.layer.contents = UIImage(named: "videoBg2")?.CGImage
        
        cyclePlayBtn = UIButton()
        cyclePlayBtn.setBackgroundImage(UIImage(named: "musicCyclePlay"), forState: UIControlState.Normal)
        cyclePlayBtn.frame = CGRectMake(20, 10, 30, 30)
        cyclePlayBtn.addTarget(self, action: "cycleBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        musicView.addSubview(cyclePlayBtn)
        
        shareBtn = UIButton()
        shareBtn.setBackgroundImage(UIImage(named: "shareIconWhite"), forState: UIControlState.Normal)
        shareBtn.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width - 55, 10, 30, 30)
        shareBtn.addTarget(self, action: "shareBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        musicView.addSubview(shareBtn)
        
        musicNameLayer=CATextLayer()
        musicNameLayer.foregroundColor = UIColor.whiteColor().CGColor
        musicNameLayer.string = "Hello World!"
        musicNameLayer.frame = CGRectMake(75, 10, UIScreen.mainScreen().bounds.size.width - 150, 20)
        musicNameLayer.fontSize = 16.0
        musicNameLayer.contentsScale = 2.0
        musicNameLayer.alignmentMode = kCAAlignmentCenter
        musicView.layer.addSublayer(musicNameLayer)
        
        authorNameLayer = CATextLayer()
        authorNameLayer.foregroundColor = UIColor.whiteColor().CGColor
        authorNameLayer.string = "MATI"
        authorNameLayer.frame = CGRectMake(75, 30, UIScreen.mainScreen().bounds.size.width - 150, 20)
        authorNameLayer.fontSize = 14.0
        authorNameLayer.contentsScale = 2.0
        authorNameLayer.alignmentMode = kCAAlignmentCenter
        musicView.layer.addSublayer(authorNameLayer)
        
        prePlayBtn = UIButton(frame: CGRectMake(40, 80, 30, 30))
        prePlayBtn.addTarget(self, action: "preBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        prePlayBtn.setBackgroundImage(UIImage(named: "musicPrePlay"), forState: UIControlState.Normal)
        musicView.addSubview(prePlayBtn)
        
        nextPlayBtn = UIButton(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width - 70, 80, 30, 30))
        nextPlayBtn.addTarget(self, action: "nextBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        nextPlayBtn.setBackgroundImage(UIImage(named: "musicNextPlay"), forState: UIControlState.Normal)
        musicView.addSubview(nextPlayBtn)
        
        cdView = UIImageView(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width / 2 - 45, 55, 100, 100))
        cdView.image = UIImage(named: "articleImage")!
        cdView.layer.cornerRadius =  cdView.frame.size.width / 2
        cdView.clipsToBounds = true
        cdView.layer.borderWidth = 5.0
        cdView.layer.borderColor = UIColor.blackColor().CGColor
        musicView.addSubview(cdView)
        
        var playLayer:CALayer = CALayer()
        playLayer.contents = UIImage(named: "musicPlayIcon")?.CGImage
        playLayer.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width / 2 - 25, 75, 60, 60)
        musicView.layer.addSublayer(playLayer)
    }
    
    override func viewDidAppear(animated: Bool) {
        /*
        if (mapViewController == nil){
            mapViewController = MusicMapViewController()
            mapViewController?.view.frame = CGRectMake(0, musicView.frame.origin.y,musicView.frame.size.width, musicView.frame.size.height + tableView.frame.size.height)
            mapViewController!.view.backgroundColor = UIColor.redColor()
            self.addChildViewController(mapViewController!)
            self.view.addSubview(mapViewController!.view)
            mapViewController!.view.hidden = true
        }*/
        listBtn.selected = true
        mapBtn.selected = false
    }
    
    @IBAction func listBtnClick(sender: UIButton) {
        mapViewController!.view.hidden = true
        sender.selected = true
        mapBtn.selected = false
    }
    
    @IBAction func mapBtnClick(sender: UIButton) {
        mapViewController!.view.hidden = false
        sender.selected = true
        listBtn.selected = false
    }
    
    func cycleBtnClick(target:UIButton){
    
    }
    
    func shareBtnClick(target:UIButton){
    
    }
    
    func preBtnClick(target:UIButton){
    
    }
    
    func nextBtnClick(target:UIButton){
    
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("music view did disappear")
        mapViewController?.view.removeFromSuperview()
        mapViewController = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
