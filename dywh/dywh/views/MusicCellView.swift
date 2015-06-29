//
//  MusicCellView.swift
//  dywh
//
//  Created by lotusprize on 15/6/6.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import Foundation

class MusicCellView: UIView {
    
    var boardIconLayer:CALayer = CALayer()
    var musicNameTextLayer:CATextLayer = CATextLayer()
    var musicAhthorTextLayer:CATextLayer = CATextLayer()
    var musicName:String?
    var musicAuthor:String?
    
    init(frame: CGRect,musicName:String, musicAuthor:String) {
        super.init(frame: frame)
        self.musicName = musicName
        self.musicAuthor = musicAuthor
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        
        boardIconLayer.frame = CGRectMake(0, self.frame.origin.y + 10, self.frame.size.height - 25, self.frame.size.height - 25)
        boardIconLayer.contents = UIImage(named: "musicPlaying")?.CGImage
        boardIconLayer.hidden = true
        self.layer.addSublayer(boardIconLayer)
        
        musicNameTextLayer.foregroundColor = UIColor.whiteColor().CGColor
        musicNameTextLayer.string = musicName
        musicNameTextLayer.frame = CGRectMake(40, self.frame.origin.y + 5, self.frame.size.width - 30, 25)
        musicNameTextLayer.fontSize = 19.0
        musicNameTextLayer.contentsScale = 2.0
        musicNameTextLayer.alignmentMode = kCAAlignmentJustified
        musicNameTextLayer.backgroundColor = UIColor.clearColor().CGColor
        musicNameTextLayer.wrapped = true
        musicNameTextLayer.truncationMode = kCATruncationEnd
        self.layer.addSublayer(musicNameTextLayer)

        musicAhthorTextLayer.foregroundColor = UIColor.whiteColor().CGColor
        musicAhthorTextLayer.string = musicAuthor
        musicAhthorTextLayer.frame = CGRectMake(40, self.frame.origin.y + 30, self.frame.size.width - 30, 20)
        musicAhthorTextLayer.fontSize = 16.0
        musicAhthorTextLayer.contentsScale = 2.0
        musicAhthorTextLayer.alignmentMode = kCAAlignmentJustified
        musicAhthorTextLayer.backgroundColor = UIColor.clearColor().CGColor
        self.layer.addSublayer(musicAhthorTextLayer)

        
    }
}