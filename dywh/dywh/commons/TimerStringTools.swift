//
//  TimerStringTools.swift
//  dywh
//
//  Created by lotusprize on 15/6/11.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import Foundation

class TimerStringTools{
    
    func getTotleTime(time:String)->Int{
        println("######:\(time)")
        var totalTime:Int = 0
        var timeArray:Array = time.componentsSeparatedByString(":")
        println(timeArray.count)
        println("\(timeArray[0]),\(timeArray[1])")
        let index1 = advance(timeArray[0].startIndex, 1)
        var minutes:Int = time.substringFromIndex(index1).toInt()!
        
        var seconds:Int = timeArray[1].substringWithRange()
        totalTime = minutes * 60 + seconds
        return totalTime
    }
    
}