//
//  VideoViewController.swift
//  dywh
//
//  Created by lotusprize on 15/5/22.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit

class VideoViewController: HXWHViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var listBtn: UIButton!
    @IBOutlet weak var mapBtn: UIButton!
    
    @IBOutlet weak var videoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listBtn.setBackgroundImage(UIImage(named: "btnSelected"), forState: UIControlState.Selected)
        listBtn.setBackgroundImage(UIImage(named: "btnNormal"), forState: UIControlState.Normal)
        mapBtn.setBackgroundImage(UIImage(named: "btnSelected"), forState: UIControlState.Selected)
        mapBtn.setBackgroundImage(UIImage(named: "btnNormal"), forState: UIControlState.Normal)
        listBtn.selected = true

        videoTableView.delegate = self
        videoTableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier:String = "Cell"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? UITableViewCell
        
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Value2,
                reuseIdentifier: identifier)
            cell?.frame = CGRectMake(0, 0, tableView.frame.size.width, 200)
            cell?.backgroundColor = UIColor.blackColor()
            var videoCellView:VideoCellView = VideoCellView(frame: CGRectMake(0, 0, tableView.frame.size.width, 200), bgImage: UIImage(named: "videoBg1")!, titleText: "新通道夏令营总宣传片", locationText: "通道 平坦乡", videoTimeLongText: "00:10:20")
            cell?.addSubview(videoCellView)
            
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    @IBAction func listBtnClick(sender: UIButton) {
        sender.selected = true
        mapBtn.selected = false
    }
    
    @IBAction func mapBtnClick(sender: UIButton) {
        sender.selected = true
        listBtn.selected = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
