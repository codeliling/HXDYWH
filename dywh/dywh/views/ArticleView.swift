//
//  ArticleView.swift
//  dywh
//
//  Created by lotusprize on 15/4/16.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import Foundation

class ArticleView: UIView {
    
    var imageName:String?
    var titleName:String?
    
    init(frame: CGRect, imageName:String, titleName:String) {
        self.imageName = imageName
        self.titleName = titleName
        super.init(frame:frame)

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        var image = UIImage(named: imageName!)
        var imageCG = image?.CGImage
        //image?.drawAtPoint(CGPointZero)
        
        var imageLayer:CALayer = CALayer()
        imageLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 35)
        imageLayer.contents = imageCG
        self.layer.addSublayer(imageLayer)
        
        var titleLayer:CATextLayer = CATextLayer()
        titleLayer.foregroundColor = UIColor.whiteColor().CGColor
        titleLayer.string = titleName
        titleLayer.frame = CGRectMake(5, self.frame.size.height - 30, self.frame.size.width, 30)
        titleLayer.fontSize = 16.0
        titleLayer.contentsScale = 2.0
        titleLayer.alignmentMode = kCAAlignmentJustified
        self.layer.addSublayer(titleLayer)
    }
}