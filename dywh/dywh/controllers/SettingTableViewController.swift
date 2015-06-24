//
//  SettingTableViewController.swift
//  dywh
//
//  Created by lotusprize on 15/6/6.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit
import Haneke

class SettingTableViewController: UITableViewController {
    
    let cache = Shared.imageCache
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRectZero);
        var attributes:[NSObject:AnyObject] = [NSForegroundColorAttributeName:UIColor(red:1.0, green: 1.0, blue: 1.0, alpha: 1)]
        if let font = UIFont(name: "Helvetica-Bold", size: 20) {
            attributes[NSFontAttributeName] = font
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = attributes;
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //tableView.cellForRowAtIndexPath(indexPath)?.selectionStyle = UITableViewCellSelectionStyle.None
        if (indexPath.row == 0){
            cache.removeAll()
            self.view.makeToast("清除成功！", duration: 2.0, position: CSToastPositionCenter)
        }
        else if (indexPath.row == 1){
        
        }
        else if (indexPath.row == 2){
        
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}
