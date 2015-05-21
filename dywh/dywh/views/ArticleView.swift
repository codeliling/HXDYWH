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
        image?.drawAtPoint(CGPointZero)
        
        
    }
}