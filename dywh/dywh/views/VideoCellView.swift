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
    
    init(frame: CGRect, titleText:String, locationText:String, videoTimeLongText:String) {
        self.titleText = titleText
        self.locationText = locationText
        self.videoTimeLongText = videoTimeLongText
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
        self.layer.addSublayer(imageLayer)
        
        titleLayer.foregroundColor = UIColor.whiteColor().CGColor
        titleLayer.string = titleText
        titleLayer.frame = CGRectMake(5, self.frame.size.height - 40, self.frame.size.width, 20)
        titleLayer.fontSize = 16.0
        titleLayer.contentsScale = 2.0
        titleLayer.alignmentMode = kCAAlignmentJustified
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
        
        var shareIcon:CALayer = CALayer()
        shareIcon.frame = CGRectMake(self.frame.size.width - 40, self.frame.size.height - 40, 30, 30)
        shareIcon.contents = UIImage(named: "shareIconWhite")?.CGImage
        self.layer.addSublayer(shareIcon)
        
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
}