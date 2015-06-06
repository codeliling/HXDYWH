//
//  MusicCellView.swift
//  dywh
//
//  Created by lotusprize on 15/6/6.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import Foundation

class MusicCellView: UIView {
    
    var boardIconLayer:CALayer!
    var musicNameTextLayer:CATextLayer!
    var musicAhthorTextLayer:CATextLayer!
    var musicName:String?
    var musicAuthor:String?
    
    init(frame: CGRect,musicName:String, musicAuthor:String) {
        super.init(frame: frame)
        self.musicName = musicName
        self.musicAuthor = musicAuthor
        
        boardIconLayer = CALayer()
        musicNameTextLayer = CATextLayer()
        musicAhthorTextLayer = CATextLayer()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        boardIconLayer.frame = CGRectMake(10, self.frame.origin.y + 10, self.frame.size.height - 20, self.frame.size.height - 20)
        
        musicNameTextLayer.foregroundColor = UIColor.whiteColor().CGColor
        musicNameTextLayer.string = musicName
        musicNameTextLayer.frame = CGRectMake(0, self.frame.origin.y + 5, self.frame.size.width, 20)
        musicNameTextLayer.fontSize = 20.0
        musicNameTextLayer.contentsScale = 2.0
        musicNameTextLayer.alignmentMode = kCAAlignmentJustified
        musicNameTextLayer.backgroundColor = UIColor.clearColor().CGColor
        self.layer.addSublayer(musicNameTextLayer)

        musicAhthorTextLayer.foregroundColor = UIColor.whiteColor().CGColor
        musicAhthorTextLayer.string = musicAuthor
        musicAhthorTextLayer.frame = CGRectMake(0, self.frame.origin.y + 25, self.frame.size.width, 20)
        musicAhthorTextLayer.fontSize = 16.0
        musicAhthorTextLayer.contentsScale = 2.0
        musicAhthorTextLayer.alignmentMode = kCAAlignmentJustified
        musicAhthorTextLayer.backgroundColor = UIColor.clearColor().CGColor
        self.layer.addSublayer(musicAhthorTextLayer)

        
    }
}