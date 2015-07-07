//
//  MusicMapViewController.swift
//  dywh
//
//  Created by lotusprize on 15/5/22.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit
import Haneke

class MusicMapViewController: UIViewController,BMKMapViewDelegate, UMSocialUIDelegate{
     let cache = Shared.imageCache
    var mapView:BMKMapView!
    var musicList:[MusicModel] = []
    var musicModel:MusicModel?
    var musicPanel:UIView!
    var cdView:UIImageView!
    var progressView:UIProgressView!
    var musicName:CATextLayer!
    var musicAuthor:CATextLayer!
    var leftTimeLayer:CATextLayer!
    var rightTimeLayer:CATextLayer!
    
    var audioStream:AudioStreamer?
    var cdViewAngle:CGFloat = 1.0
    var cycleAnimationFlag:Bool = true
    var timer:NSTimer?
    var settingTotalTime:Bool = false
    var shareUrl:String!
    var image:UIImage?
    
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
        
        musicPanel = UIView(frame: CGRectMake(10, UIScreen.mainScreen().bounds.size.height - 230, UIScreen.mainScreen().bounds.size.width - 20, 70))
        musicPanel.backgroundColor = UIColor.whiteColor()
        musicPanel.alpha = 0.8
        
        cdView = UIImageView(frame: CGRectMake(5, -40, 80, 80))
        cdView.image = UIImage(named: "musicCDCover")!
        cdView.layer.cornerRadius =  cdView.frame.size.width / 2
        cdView.clipsToBounds = true
        cdView.layer.borderWidth = 5.0
        cdView.layer.borderColor = UIColor.blackColor().CGColor
        cdView.userInteractionEnabled = true
        musicPanel.addSubview(cdView)
        
        var playLayer:UIButton = UIButton()
        playLayer.setBackgroundImage(UIImage(named: "musicPlayIcon"), forState: UIControlState.Normal)
        playLayer.frame = CGRectMake(25, -20, 40, 40)
        playLayer.addTarget(self, action: "playBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        musicPanel.addSubview(playLayer)
        
        var shareBtn:UIButton = UIButton()
        shareBtn.setBackgroundImage(UIImage(named: "shareIconBlack"), forState: UIControlState.Normal)
        shareBtn.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width - 60, 15, 35, 35)
        shareBtn.addTarget(self, action: "shareBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        musicPanel.addSubview(shareBtn)
        
        musicName = CATextLayer()
        musicName.fontSize = 16.0
        musicName.foregroundColor = UIColor.grayColor().CGColor
        musicName.string = "Tomorry Is Coming"
        musicName.contentsScale = 2.0
        musicName.alignmentMode = kCAAlignmentCenter
        musicName.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width/2 - 100, 5, 200, 20)
        self.musicPanel.layer.addSublayer(musicName)
        
        musicAuthor = CATextLayer()
        musicAuthor.fontSize = 14.0
        musicAuthor.string = "Jack Bour"
        musicAuthor.alignmentMode = kCAAlignmentCenter
        musicAuthor.contentsScale = 2.0
        musicAuthor.foregroundColor = UIColor.grayColor().CGColor
        musicAuthor.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width/2 - 100, 30, 200, 20)
        self.musicPanel.layer.addSublayer(musicAuthor)
        
        leftTimeLayer = CATextLayer()
        leftTimeLayer.fontSize = 14.0
        leftTimeLayer.alignmentMode = kCAAlignmentLeft
        leftTimeLayer.contentsScale = 2.0
        leftTimeLayer.foregroundColor = UIColor.grayColor().CGColor
        leftTimeLayer.frame = CGRectMake(10, 50, 80, 15)
        self.musicPanel.layer.addSublayer(leftTimeLayer)
        
        rightTimeLayer = CATextLayer()
        rightTimeLayer.fontSize = 14.0
        rightTimeLayer.alignmentMode = kCAAlignmentLeft
        rightTimeLayer.contentsScale = 2.0
        rightTimeLayer.foregroundColor = UIColor.grayColor().CGColor
        rightTimeLayer.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width - 70, 50, 80, 15)
        self.musicPanel.layer.addSublayer(rightTimeLayer)
        
        progressView = UIProgressView(frame: CGRectMake(0, 68, UIScreen.mainScreen().bounds.size.width - 20, 2))
        progressView.progressTintColor = UIColor(red: 229/255.0, green: 0, blue: 55.0/255.0, alpha: 1.0)
        progressView.trackTintColor = UIColor(red: 170/255.0, green: 170/255.0, blue: 170/255.0, alpha: 1.0)
        musicPanel.addSubview(progressView)
        self.view.addSubview(musicPanel)
        musicPanel.hidden = true
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "closeMusicOfReceivedNotification:", name: "MapCloseMusicNotification", object: nil)
    }
    
    
    func mapView(mapView: BMKMapView!, didSelectAnnotationView view: BMKAnnotationView!) {
        
        var title:String = view.annotation.title!()
        
        for mModle in musicList{
            if title == mModle.musicName{
                musicModel = mModle
            }
        }
        
        if musicModel != nil{
            musicPanel.hidden = false
            musicName.string = musicModel?.musicName
            musicAuthor.string = musicModel?.musicAuthor
            shareUrl = musicModel?.musicFileUrl
            audioStream = AudioStreamer(URL: NSURL(string: musicModel!.musicFileUrl!))
        }
    }
    
    func addMapPoint(musicModel:MusicModel){
        var annotation:BMKPointAnnotation = BMKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(Double(musicModel.latitude), Double(musicModel.longitude));
        annotation.title = musicModel.musicName
        
        mapView.addAnnotation(annotation)
        musicList.append(musicModel)
    }
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if annotation.isKindOfClass(BMKPointAnnotation.classForCoder()) {
            var newAnnotationView:BMKPinAnnotationView = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: "articleAnnotation");
            newAnnotationView.pinColor = UInt(BMKPinAnnotationColorPurple)
            newAnnotationView.animatesDrop = true;// 设置该标注点动画显示
            newAnnotationView.annotation = annotation;
            newAnnotationView.image = UIImage(named: "locationIcon")
            newAnnotationView.frame = CGRectMake(newAnnotationView.frame.origin.x, newAnnotationView.frame.origin.y, 30, 30)
            
            newAnnotationView.paopaoView = nil
            return newAnnotationView
        }
        return nil
    }
    
    func mapView(mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
        println("*********:\(view.annotation.title)")
        
    }
    
    func playBtnClick(button:UIButton){
        if audioStream != nil{
            if audioStream!.isPlaying(){
                audioStream?.pause()
                cycleAnimationFlag = false
                button.setBackgroundImage(UIImage(named: "musicPauseIcon"), forState: UIControlState.Normal)
            }
            else if audioStream!.isPaused(){
                audioStream?.start()
                cycleAnimationFlag = true
                button.setBackgroundImage(UIImage(named: "musicPlayIcon"), forState: UIControlState.Normal)
                self.CDCycleAnimation(cdView)
            }
            else{
                audioStream?.start()
                cycleAnimationFlag = true
                button.setBackgroundImage(UIImage(named: "musicPlayIcon"), forState: UIControlState.Normal)
                self.CDCycleAnimation(cdView)
                resetPlayMusicStatus()
            }
            startUpdateProgressView()
        }
    }
    
    func shareBtnClick(button:UIButton){
        if musicModel != nil {
            UMSocialSnsService.presentSnsIconSheetView(self, appKey: "556a5c3e67e58e57a3003c8a", shareText: self.musicModel?.musicName, shareImage: image, shareToSnsNames: [UMShareToQzone,UMShareToQQ,UMShareToSms,UMShareToWechatFavorite,UMShareToWechatSession,UMShareToWechatTimeline], delegate: self)
            UMSocialData.defaultData().extConfig.wechatSessionData.url = self.shareUrl
            UMSocialData.defaultData().extConfig.wechatTimelineData.url = self.shareUrl
            UMSocialData.defaultData().extConfig.wechatFavoriteData.url = self.shareUrl
            UMSocialData.defaultData().extConfig.qqData.url = self.shareUrl
            UMSocialData.defaultData().extConfig.qzoneData.url = self.shareUrl
        }
        else{
            self.view.makeToast("无分享数据", duration: 2.0, position: kCAGravityBottom)
        }
    }

    func CDCycleAnimation(cdView:UIView){
        var endAngle:CGAffineTransform = CGAffineTransformMakeRotation(cdViewAngle * CGFloat(M_PI / 180.0));
        
        UIView.animateWithDuration(0.01, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            cdView.transform = endAngle
            }) { (Bool) -> Void in
                self.cdViewAngle += 2.0
                
                if (self.audioStream != nil && self.audioStream!.isFinishing()){
                    self.cycleAnimationFlag = false
                }
                
                if self.cycleAnimationFlag{
                    self.CDCycleAnimation(cdView)
                }
        }
    }
    
    func resetPlayMusicStatus(){
        progressView.progress = 0.0
        settingTotalTime = false
    }
    
    func startUpdateProgressView(){
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateProgressView", userInfo: nil, repeats:true)
        timer!.fire()
    }
    
    func updateProgressView(){
        
        if audioStream != nil{
            var totalTime = TimerStringTools().getTotleTime(audioStream!.totalTime())
            if totalTime > 0 {
                if !settingTotalTime{
                    
                    rightTimeLayer.string = (audioStream!.totalTime() as NSString).substringFromIndex(1)
                }
                settingTotalTime = true
                leftTimeLayer.string = audioStream?.currentTime()
            }
            
            var currentTime:Int = TimerStringTools().getCurrentTotleTime(audioStream!.currentTime())
            if(Double(currentTime) < audioStream!.duration)
            {
                progressView.progress = Float(Double(currentTime)/audioStream!.duration)
            }
            
            if audioStream!.isFinishing(){
                leftTimeLayer.string = "00:00"
                progressView.progress = 0.0
                timer!.invalidate()
            }
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
    
    func closeMusicOfReceivedNotification(notification:NSNotification){
        if audioStream != nil{
            if audioStream!.isPlaying(){
                audioStream?.stop()
            }
        }
    }
    
    func initImageData(url:String){
        let URL = NSURL(string: url)!
        let fetcher = NetworkFetcher<UIImage>(URL: URL)
        
        cache.fetch(fetcher: fetcher).onSuccess { image in
            // Do something with image
            self.image = image
        }
        
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "MapCloseMusicNotification", object: nil)
    }
}
