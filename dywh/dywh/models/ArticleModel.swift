//
//  ArticleModel.swift
//  dywh
//
//  Created by lotusprize on 15/6/5.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import Foundation

class ArticleModel: NSObject {
    var articleId:Int!
    var articleName:String?
    var articleTag:String?
    var articleImageUrl:String?
    
    var latitude:CGFloat!
    var longitude:CGFloat!
    
    var articleDescription:String?
}