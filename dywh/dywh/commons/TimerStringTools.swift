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
        
        var totalTime:Int = 0
        var timeArray:Array = time.componentsSeparatedByString(":")
        println(timeArray.count)
        println("\(timeArray[0]),\(timeArray[1])")
        
        var minutes = 0
        var m = 0
        
        if (count(timeArray[0]) == 3){
            for character in timeArray[0]{
                if (m == 0){
                    minutes += String(character).toInt()!*10
                }
                if (m == 1){
                    minutes += String(character).toInt()!
                }
                m++
            }
        }
        else if (count(timeArray[0]) == 2){
            for character in timeArray[0]{
                
                if (m == 1){
                    minutes += String(character).toInt()!
                }
                m++
            }

        }
        
        var seconds = 0
        var i:Int = 0
        for character in timeArray[1]{
            if (i == 0){
                seconds += String(character).toInt()!*10
            }
            if (i == 1){
                seconds += String(character).toInt()!
            }
            i++
        }
        
        
        totalTime = minutes * 60 + seconds
        return totalTime
    }
    
    func getCurrentTotleTime(time:String)->Int{
        
        var totalTime:Int = 0
        var timeArray:Array = time.componentsSeparatedByString(":")
        println(timeArray.count)
        println("\(timeArray[0]),\(timeArray[1])")
        
        var minutes = 0
        var m = 0
        
        if (count(timeArray[0]) == 2){
            for character in timeArray[0]{
                if (m == 0){
                    minutes += String(character).toInt()!*10
                }
                if (m == 1){
                    minutes += String(character).toInt()!
                }
                m++
            }
        }
        else if (count(timeArray[0]) == 1){
            minutes += timeArray[0].toInt()!
        }
        
        var seconds = 0
        var i:Int = 0
        for character in timeArray[1]{
            if (i == 0){
                seconds += String(character).toInt()!*10
            }
            if (i == 1){
                seconds += String(character).toInt()!
            }
            i++
        }
        
        
        totalTime = minutes * 60 + seconds
        return totalTime
    }
}