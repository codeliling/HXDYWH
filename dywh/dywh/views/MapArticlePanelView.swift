//
//  MapArticlePanelView.swift
//  dywh
//
//  Created by lotusprize on 15/6/8.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import Foundation

class MapArticlePanelView: UIView {
    
    var imageLayer:CALayer = CALayer()
    var titleLayer:CATextLayer = CATextLayer()
    var descriptionLayer:CATextLayer = CATextLayer()
    var title:String?
    var articleDescription:String?
    
    init(frame: CGRect, title:String, articleDescription:String) {
        super.init(frame: frame)
        self.title = title
        self.articleDescription = articleDescription
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        imageLayer.frame = CGRectMake(3, 3, self.frame.width / 7 * 3, self.frame.height - 6)
        self.layer.addSublayer(imageLayer)
        
        titleLayer.frame = CGRectMake(self.frame.width / 7 * 3 + 10, 10, self.frame.width / 7 * 3, self.frame.height / 3)
        titleLayer.foregroundColor = UIColor.darkGrayColor().CGColor
        titleLayer.fontSize = 22.0
        titleLayer.string = title
        titleLayer.contentsScale = 2.0
        titleLayer.wrapped = true
        titleLayer.truncationMode = kCATruncationEnd
        self.layer.addSublayer(titleLayer)
        
        descriptionLayer.frame = CGRectMake(self.frame.width / 7 * 3 + 10, 10 + self.frame.height / 3, self.frame.width / 7 * 3, self.frame.height / 3 * 2 - 5)
        descriptionLayer.foregroundColor = UIColor
            .darkGrayColor().CGColor
        descriptionLayer.string = articleDescription
        descriptionLayer.fontSize = 16.0
        descriptionLayer.contentsScale = 2.0
        
        self.layer.addSublayer(descriptionLayer)
    }
    
}