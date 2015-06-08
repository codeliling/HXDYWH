//
//  MusicViewController.swift
//  dywh
//
//  Created by lotusprize on 15/5/22.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit
import Alamofire
import Haneke

class MusicViewController: HXWHViewController,UITableViewDataSource,UITableViewDelegate {
    
    var mapViewController:MusicMapViewController?
    let cache = Shared.imageCache
    
    @IBOutlet weak var listBtn: UIButton!
    
    @IBOutlet weak var mapBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var musicView: UIView!
    
    var cyclePlayBtn:UIButton!
    var shareBtn:UIButton!
    var prePlayBtn:UIButton!
    var nextPlayBtn:UIButton!
    
    var musicNameLayer:CATextLayer!
    var authorNameLayer:CATextLayer!
    
    var musicName:String?
    var musicAuthorName:String?
    var cdView:UIImageView!
    var musicList:[MusicModel] = []
    var currentMusicIndex:Int = 0
    
    var audioStream:AudioStreamer?
    var cdViewAngle:CGFloat = 1.0
    var cycleAnimationFlag:Bool = true
    
    @IBOutlet weak var musicProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listBtn.setBackgroundImage(UIImage(named: "btnSelected"), forState: UIControlState.Selected)
        listBtn.setBackgroundImage(UIImage(named: "btnNormal"), forState: UIControlState.Normal)
        mapBtn.setBackgroundImage(UIImage(named: "btnSelected"), forState: UIControlState.Selected)
        mapBtn.setBackgroundImage(UIImage(named: "btnNormal"), forState: UIControlState.Normal)
        listBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
        mapBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
        
        musicView.layer.contents = UIImage(named: "musicPanelBg")?.CGImage
        
        cyclePlayBtn = UIButton()
        cyclePlayBtn.setBackgroundImage(UIImage(named: "musicCyclePlay"), forState: UIControlState.Normal)
        cyclePlayBtn.frame = CGRectMake(20, 10, 30, 30)
        cyclePlayBtn.addTarget(self, action: "cycleBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        musicView.addSubview(cyclePlayBtn)
        
        shareBtn = UIButton()
        shareBtn.setBackgroundImage(UIImage(named: "shareIconWhite"), forState: UIControlState.Normal)
        shareBtn.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width - 55, 10, 30, 30)
        shareBtn.addTarget(self, action: "shareBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        musicView.addSubview(shareBtn)
        
        musicNameLayer=CATextLayer()
        musicNameLayer.foregroundColor = UIColor.whiteColor().CGColor
        musicNameLayer.frame = CGRectMake(75, 10, UIScreen.mainScreen().bounds.size.width - 150, 20)
        musicNameLayer.fontSize = 16.0
        musicNameLayer.contentsScale = 2.0
        musicNameLayer.alignmentMode = kCAAlignmentCenter
        musicView.layer.addSublayer(musicNameLayer)
        
        authorNameLayer = CATextLayer()
        authorNameLayer.foregroundColor = UIColor.whiteColor().CGColor
        authorNameLayer.frame = CGRectMake(75, 30, UIScreen.mainScreen().bounds.size.width - 150, 20)
        authorNameLayer.fontSize = 14.0
        authorNameLayer.contentsScale = 2.0
        authorNameLayer.alignmentMode = kCAAlignmentCenter
        musicView.layer.addSublayer(authorNameLayer)
        
        prePlayBtn = UIButton(frame: CGRectMake(40, 80, 30, 30))
        prePlayBtn.addTarget(self, action: "preBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        prePlayBtn.setBackgroundImage(UIImage(named: "musicPrePlay"), forState: UIControlState.Normal)
        musicView.addSubview(prePlayBtn)
        
        nextPlayBtn = UIButton(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width - 70, 80, 30, 30))
        nextPlayBtn.addTarget(self, action: "nextBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        nextPlayBtn.setBackgroundImage(UIImage(named: "musicNextPlay"), forState: UIControlState.Normal)
        musicView.addSubview(nextPlayBtn)
        
        cdView = UIImageView(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width / 2 - 45, 55, 100, 100))
        cdView.image = UIImage(named: "musicCDCover")!
        cdView.layer.cornerRadius =  cdView.frame.size.width / 2
        cdView.clipsToBounds = true
        cdView.layer.borderWidth = 5.0
        cdView.layer.borderColor = UIColor.blackColor().CGColor
        cdView.userInteractionEnabled = true
        musicView.addSubview(cdView)
        
        var playLayer:UIButton = UIButton()
        playLayer.setBackgroundImage(UIImage(named: "musicPlayIcon"), forState: UIControlState.Normal)
        playLayer.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width / 2 - 25, 75, 60, 60)
        playLayer.addTarget(self, action: "playBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        musicView.addSubview(playLayer)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView(frame: CGRectZero);
        
        self.loadingMusicDataList()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if (mapViewController == nil){
            mapViewController = MusicMapViewController()
            mapViewController?.view.frame = CGRectMake(0, musicView.frame.origin.y,musicView.frame.size.width, musicView.frame.size.height + tableView.frame.size.height)
            mapViewController!.view.backgroundColor = UIColor.redColor()
            self.addChildViewController(mapViewController!)
            self.view.addSubview(mapViewController!.view)
            mapViewController!.view.hidden = true
        }
        listBtn.selected = true
        mapBtn.selected = false
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
    
    func cycleBtnClick(target:UIButton){
        println("cycleBtnClick")
        
        
    }
    
    func shareBtnClick(target:UIButton){
    
    }
    
    func playBtnClick(target:UIButton){
        
        if audioStream != nil{
            println(audioStream!.isPlaying())
            println(audioStream!.isPaused())
            if audioStream!.isPlaying(){
                audioStream?.pause()
                cycleAnimationFlag = false
                target.setBackgroundImage(UIImage(named: "musicPauseIcon"), forState: UIControlState.Normal)
            }
            else if audioStream!.isPaused(){
                audioStream?.start()
                cycleAnimationFlag = true
                target.setBackgroundImage(UIImage(named: "musicPlayIcon"), forState: UIControlState.Normal)
                self.CDCycleAnimation(cdView)
            }
        }
        
        
    }
    
    func preBtnClick(target:UIButton){
        currentMusicIndex--
        if (currentMusicIndex >= 0){
            cdViewAngle = 1.0
            var musicModel:MusicModel = musicList[currentMusicIndex]
            if let playing = audioStream?.isPlaying(){
                audioStream?.stop()
            }
            else if let pause = audioStream?.isPaused(){
                audioStream?.stop()
            }
            audioStream = AudioStreamer(URL: NSURL(string: musicModel.musicFileUrl!))
            audioStream?.start()
        }
        else{
            //show Tips
        }
    }
    
    func nextBtnClick(target:UIButton){
        currentMusicIndex++
        if (currentMusicIndex < musicList.count){
            cdViewAngle = 1.0
            var musicModel:MusicModel = musicList[currentMusicIndex]
            if let playing = audioStream?.isPlaying(){
                audioStream?.stop()
            }
            else if let pause = audioStream?.isPaused(){
                audioStream?.stop()
            }
            audioStream = AudioStreamer(URL: NSURL(string: musicModel.musicFileUrl!))
            audioStream?.start()
        }
        else{
            //show Tips
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var musicModel:MusicModel = musicList[indexPath.row]
        var cell:MusicTableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? MusicTableViewCell
       
        for view in cell!.contentView.subviews {
            if let v = view as? MusicCellView{
                cell?.musicContentView.musicAuthor = musicModel.musicAuthor!
                cell?.musicContentView.musicName = musicModel.musicName!
                cell?.setNeedsDisplay()
            }
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        var cell:MusicTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as! MusicTableViewCell
        cell.musicContentView.boardIconLayer.opacity = 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell:MusicTableViewCell? = tableView.cellForRowAtIndexPath(indexPath) as? MusicTableViewCell
        cell?.musicContentView.boardIconLayer.opacity = 1.0
        
        var musicModel:MusicModel = musicList[indexPath.row]
        musicNameLayer.string = musicModel.musicName
        authorNameLayer.string = musicModel.musicAuthor
        if (musicModel.musicFileUrl != nil){
            audioStream = AudioStreamer(URL: NSURL(string: musicModel.musicFileUrl!))
            audioStream?.start()
            currentMusicIndex = indexPath.row
            self.CDCycleAnimation(cdView)
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func loadingMusicDataList(){
        Alamofire.request(.GET, ServerUrl.ServerContentURL, parameters: ["content_type":"3"])
            .responseJSON { (req, res, json, error) in
                if(error != nil) {
                    NSLog("Error: \(error)")
                    println(req)
                    println(res)
                }
                else {
                    println(json)
                    var resultDict:NSDictionary? = json as? NSDictionary
                    var dataDict:NSDictionary? = resultDict?.objectForKey("data") as? NSDictionary
                    var success:Int = dataDict?.objectForKey("success") as! Int
                    var count:Int = dataDict?.objectForKey("count") as! Int
                    if success == 1 && count > 0{
                        var articles:NSArray = dataDict?.objectForKey("articles") as! NSArray
                        var musicModel:MusicModel?
                        for tempDict in articles{
                            musicModel = MusicModel()
                            musicModel?.musicName = tempDict.objectForKey("title") as? String
                            musicModel?.musicAuthor = tempDict.objectForKey("author") as? String
                            var assetArray:NSArray? = tempDict.objectForKey("assets") as? NSArray
                            if (assetArray?.count > 0){
                                var assetDict:NSDictionary = assetArray?.objectAtIndex(0) as! NSDictionary
                                musicModel?.musicFileUrl = assetDict.objectForKey("media_file") as? String
                            }
                            
                            musicModel?.musicId = tempDict.objectForKey("id") as! Int
                            musicModel?.musicImageUrl = tempDict.objectForKey("profile") as? String
                            self.musicList.append(musicModel!)
                        }
                        self.tableView.reloadData()
                    }
                }
        }
    }
    
    func CDCycleAnimation(cdView:UIView){
        var endAngle:CGAffineTransform = CGAffineTransformMakeRotation(cdViewAngle * CGFloat(M_PI / 180.0));
        
        UIView.animateWithDuration(0.01, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            cdView.transform = endAngle
        }) { (Bool) -> Void in
            self.cdViewAngle += 2.0
            
            if (self.audioStream != nil && self.audioStream!.isFinishing()){
                self.cycleAnimationFlag = false
            }
            
            if self.cycleAnimationFlag{
                self.CDCycleAnimation(cdView)
            }
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("music view did disappear")
        mapViewController?.view.removeFromSuperview()
        mapViewController = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
