//
//  VideoViewController.swift
//  dywh
//
//  Created by lotusprize on 15/5/22.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit
import Alamofire
import Haneke
import MediaPlayer

class VideoViewController: HXWHViewController, UITableViewDataSource, UITableViewDelegate {
    
    var mapViewController:VideoMapViewController?
    
    @IBOutlet weak var listBtn: UIButton!
    @IBOutlet weak var mapBtn: UIButton!
    
    @IBOutlet weak var videoTableView: UITableView!
    
    let cache = Shared.imageCache
    
    var mp:MPMoviePlayerViewController!
    var player:MPMoviePlayerController!
    var videoList:[VideoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listBtn.setBackgroundImage(UIImage(named: "btnSelected"), forState: UIControlState.Selected)
        listBtn.setBackgroundImage(UIImage(named: "btnNormal"), forState: UIControlState.Normal)
        mapBtn.setBackgroundImage(UIImage(named: "btnSelected"), forState: UIControlState.Selected)
        mapBtn.setBackgroundImage(UIImage(named: "btnNormal"), forState: UIControlState.Normal)
        listBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
        mapBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)

        videoTableView.delegate = self
        videoTableView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if (mapViewController == nil){
            mapViewController = VideoMapViewController()
            mapViewController?.view.frame = CGRectMake(0, videoTableView.frame.origin.y,videoTableView.frame.size.width, videoTableView.frame.size.height)
            mapViewController!.view.backgroundColor = UIColor.redColor()
            self.addChildViewController(mapViewController!)
            self.view.addSubview(mapViewController!.view)
            mapViewController!.view.hidden = true
        }
        listBtn.selected = true
        mapBtn.selected = false
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier:String = "Cell"
        var videoModel:VideoModel = videoList[indexPath.row]
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? UITableViewCell
        
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Value2,
                reuseIdentifier: identifier)
            cell?.frame = CGRectMake(0, 0, tableView.frame.size.width, 200)
            cell?.backgroundColor = UIColor.blackColor()
            var videoCellView:VideoCellView = VideoCellView(frame: CGRectMake(0, 0, tableView.frame.size.width, 200), bgImage: UIImage(named: "videoBg1")!, titleText: videoModel.videoName!, locationText: videoModel.videoCite!, videoTimeLongText: "")
            cell?.addSubview(videoCellView)
            self.loadImageByUrl(videoCellView, url: videoModel.videoImageUrl!)
        }
        else{
            for view in cell!.subviews {
                if let v = view as? VideoCellView{
                    self.loadImageByUrl(v, url: videoModel.videoImageUrl!)
                    v.titleLayer.string = videoModel.videoName!
                    v.locationTextLayer.string = videoModel.videoCite
                }
            }
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var videoModel:VideoModel = videoList[indexPath.row]
        mp = MPMoviePlayerViewController(contentURL: NSURL(string: videoModel.videoFileUrl!))
        mp.view.frame = self.view.bounds
        self.view.addSubview(mp.view)
        
        player = mp.moviePlayer
        player.shouldAutoplay = true;
        player.controlStyle = MPMovieControlStyle.Fullscreen;
        player.scalingMode = MPMovieScalingMode.AspectFill;
        player.play()
    }
    
    @IBAction func listBtnClick(sender: UIButton) {
        mapViewController!.view.hidden = true
        sender.selected = true
        mapBtn.selected = false
    }
    
    @IBAction func mapBtnClick(sender: UIButton) {
        mapViewController!.view.hidden = false
        sender.selected = true
        listBtn.selected = false
    }
    
    func loadImageByUrl(view:VideoCellView, url:String){
        let URL = NSURL(string: url)!
        let fetcher = NetworkFetcher<UIImage>(URL: URL)
        cache.fetch(fetcher: fetcher).onSuccess { image in
            // Do something with image
            view.imageLayer.contents = image.CGImage
        }
    }
    
    func loadingVideoDataList(){
        Alamofire.request(.GET, "", parameters: ["":""])
            .responseJSON { (req, res, json, error) in
                if(error != nil) {
                    NSLog("Error: \(error)")
                    println(req)
                    println(res)
                }
                else {
                    
                }
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("video view did disappear")
        mapViewController?.view.removeFromSuperview()
        mapViewController = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
