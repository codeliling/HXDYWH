//
//  VideoCellView.swift
//  dywh
//
//  Created by lotusprize on 15/5/22.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import Foundation

class VideoCellView: UIView {
    
    var titleText:String?
    var locationText:String?
    var videoTimeLongText:String?
    var imageLayer:CALayer!
    var titleLayer:CATextLayer!
    var timeTextLayer:CATextLayer!
    var locationTextLayer:CATextLayer
    var shareUrl:String?
    var image:UIImage?
    var controller:UIViewController?
    
    init(frame: CGRect, titleText:String, locationText:String, videoTimeLongText:String,
        shareUrl:String,image:UIImage,controller:UIViewController) {
        self.titleText = titleText
        self.locationText = locationText
        self.videoTimeLongText = videoTimeLongText
        self.shareUrl = shareUrl
        self.image = image
        self.controller = controller
        imageLayer = CALayer()
        titleLayer = CATextLayer()
        timeTextLayer = CATextLayer()
        locationTextLayer = CATextLayer()
        super.init(frame:frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        
        imageLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 45)
        imageLayer.contentsGravity = kCAGravityResize
        self.layer.addSublayer(imageLayer)
        
        titleLayer.foregroundColor = UIColor.whiteColor().CGColor
        titleLayer.string = titleText
        titleLayer.frame = CGRectMake(5, self.frame.size.height - 40, self.frame.size.width, 20)
        titleLayer.fontSize = 16.0
        titleLayer.contentsScale = 2.0
        titleLayer.alignmentMode = kCAAlignmentJustified
        titleLayer.wrapped = true
        titleLayer.truncationMode = kCATruncationEnd
        self.layer.addSublayer(titleLayer)
        
        var videoIcon:CALayer = CALayer()
        videoIcon.frame = CGRectMake(self.frame.size.width/2 - 30, self.frame.size.height/2 - 45, 60, 60)
        videoIcon.contents = UIImage(named: "musicPlayIcon")?.CGImage
        self.layer.addSublayer(videoIcon)
        
        var locationIcon:CALayer = CALayer()
        locationIcon.frame = CGRectMake(5, self.frame.size.height - 20, 16, 16)
        locationIcon.contents = UIImage(named: "modeLocationSelected")?.CGImage
        self.layer.addSublayer(locationIcon)
        
        var timeIcon:CALayer = CALayer()
        timeIcon.frame = CGRectMake(self.frame.size.width - 110, self.frame.size.height - 20, 16, 16)
        timeIcon.contents = UIImage(named: "timeIcon")?.CGImage
        self.layer.addSublayer(timeIcon)
        
        var shareIcon:UIButton = UIButton()
        shareIcon.frame = CGRectMake(self.frame.size.width - 40, self.frame.size.height - 40, 30, 30)
        shareIcon.setBackgroundImage(UIImage(named: "shareIconWhite"), forState: UIControlState.Normal)
        shareIcon.addTarget(self, action:"shareIconClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(shareIcon)
        
        timeTextLayer.foregroundColor = UIColor.whiteColor().CGColor
        timeTextLayer.string = videoTimeLongText
        timeTextLayer.frame = CGRectMake(self.frame.size.width - 90, self.frame.size.height - 20, 50, 20)
        timeTextLayer.fontSize = 12.0
        timeTextLayer.contentsScale = 2.0
        timeTextLayer.alignmentMode = kCAAlignmentJustified
        self.layer.addSublayer(timeTextLayer)
        
        locationTextLayer.foregroundColor = UIColor.whiteColor().CGColor
        locationTextLayer.string = videoTimeLongText
        locationTextLayer.frame = CGRectMake(23, self.frame.size.height - 20, 80, 20)
        locationTextLayer.fontSize = 12.0
        locationTextLayer.contentsScale = 2.0
        locationTextLayer.alignmentMode = kCAAlignmentJustified
        self.layer.addSublayer(locationTextLayer)
    }
    
    func shareIconClick(btn:UIButton){
        println("video share....")
        if shareUrl != nil {
            UMSocialSnsService.presentSnsIconSheetView(controller, appKey: "556a5c3e67e58e57a3003c8a", shareText: self.titleText, shareImage: image, shareToSnsNames: [UMShareToQzone,UMShareToTencent,UMShareToQQ,UMShareToSms,UMShareToWechatFavorite,UMShareToWechatSession,UMShareToWechatTimeline], delegate: nil)
            UMSocialData.defaultData().extConfig.wechatSessionData.url = self.shareUrl
            UMSocialData.defaultData().extConfig.wechatTimelineData.url = self.shareUrl
            UMSocialData.defaultData().extConfig.wechatFavoriteData.url = self.shareUrl
            UMSocialData.defaultData().extConfig.qqData.url = self.shareUrl
            UMSocialData.defaultData().extConfig.qzoneData.url = self.shareUrl
        }
        else{
            self.makeToast("无分享数据", duration: 2.0, position: kCAGravityBottom)
        }
    }
}