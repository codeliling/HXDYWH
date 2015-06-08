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
    var tagName:String?
    
    var titleLayer:CATextLayer!
    var imageLayer:CALayer!
    var typeLayer:CATextLayer!
    
    init(frame: CGRect, imageName:String, titleName:String,tagName:String) {
        self.imageName = imageName
        self.titleName = titleName
        self.tagName = tagName
        super.init(frame:frame)
        titleLayer = CATextLayer()
        imageLayer = CALayer()
        typeLayer = CATextLayer()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        var image = UIImage(named: imageName!)
        var imageCG = image?.CGImage
        //image?.drawAtPoint(CGPointZero)
        
        imageLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
        imageLayer.contents = imageCG
        self.layer.addSublayer(imageLayer)
        
        var backLayer:CALayer = CALayer()
        backLayer.frame = CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30)
        backLayer.opacity = 0.5
        backLayer.backgroundColor = UIColor.lightGrayColor().CGColor
        self.layer.addSublayer(backLayer)
        
        titleLayer.foregroundColor = UIColor.whiteColor().CGColor
        titleLayer.string = titleName
        titleLayer.frame = CGRectMake(0, self.frame.size.height - 25, self.frame.size.width, 20)
        titleLayer.fontSize = 16.0
        titleLayer.contentsScale = 2.0
        titleLayer.alignmentMode = kCAAlignmentJustified
        titleLayer.backgroundColor = UIColor.clearColor().CGColor
        self.layer.addSublayer(titleLayer)
        
        typeLayer.frame = CGRectMake(self.frame.size.width - 40, self.frame.size.height - 25, 30, 20)
        typeLayer.foregroundColor = UIColor.whiteColor().CGColor
        typeLayer.string = tagName
        typeLayer.fontSize = 15.0
        typeLayer.contentsScale = 2.0
        typeLayer.alignmentMode = kCAAlignmentJustified
        typeLayer.backgroundColor = UIColor(red: 229/255.0, green: 0, blue: 55.0/255.0, alpha: 1).CGColor
        self.layer.addSublayer(typeLayer)
    }
}