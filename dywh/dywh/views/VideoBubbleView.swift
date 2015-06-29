//
//  VideoBubbleView.swift
//  dywh
//
//  Created by lotusprize on 15/6/10.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import Foundation

class VideoBubbleView: UIView {
    
    var titleLayer:CATextLayer = CATextLayer()
    var iconLayer:CALayer = CALayer()
    var title:String?;
    
    init(frame: CGRect, title:String) {
        super.init(frame: frame)
        self.title = title
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        titleLayer.string = title
        titleLayer.foregroundColor = UIColor.grayColor().CGColor
        titleLayer.frame = CGRectMake(5, 10, self.frame.width - self.frame.height - 5, self.frame.height - 20)
        titleLayer.fontSize = 18.0
        titleLayer.contentsScale = 2.0
        titleLayer.wrapped = true
        titleLayer.truncationMode = kCATruncationEnd
        self.layer.addSublayer(titleLayer)
        
        iconLayer.frame = CGRectMake(self.frame.width - self.frame.height, 3, self.frame.height - 5, self.frame.height - 5)
        iconLayer.contents = UIImage(named: "musicPlayIcon")?.CGImage
        self.layer.addSublayer(iconLayer)
        
    }
    
}