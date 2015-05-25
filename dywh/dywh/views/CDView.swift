//
//  CDView.swift
//  dywh
//
//  Created by lotusprize on 15/5/25.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import Foundation

class CDView: UIView {
    
    var bgImage:UIImage!
    var bgImageLayer:CALayer!
    
    init(frame: CGRect, bgImage:UIImage) {
        self.bgImage = bgImage
        super.init(frame:frame)
    }
    
    override func drawRect(rect: CGRect) {
        var ctx:CGContextRef = UIGraphicsGetCurrentContext()
        var path:CGMutablePathRef = CGPathCreateMutable()
        CGContextSetLineWidth(ctx, 5.0)
        CGPathAddEllipseInRect(path, nil, CGRectMake(0, 0, self.frame.width, self.frame.height))
        CGContextAddPath(ctx, path)
        CGContextStrokePath(ctx)
        
        bgImageLayer = CALayer()
        bgImageLayer.contents = bgImage.CGImage!
        bgImageLayer.frame = CGRectMake(5, 5, self.frame.width - 10, self.frame.height - 10)
        bgImageLayer.cornerRadius = 10.0
        self.layer.addSublayer(bgImageLayer)
        
       
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}