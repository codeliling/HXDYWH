//
//  ServerUrl.swift
//  dywh
//
//  Created by lotusprize on 15/6/8.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import Foundation

enum ServerUrl{
    static var ServerBaseURL:String = "http://121.40.16.252/hnc"
    static var ServerContentURL:String = ServerBaseURL + "/articles_ajax/search_by_keyword"
    static var ServerArticleDetailURL:String = ServerBaseURL + "/articles_mobile/"
}