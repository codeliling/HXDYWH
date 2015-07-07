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

class MusicViewController: HXWHViewController,UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate {
    
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
    
    var currentPage:Int = 1
    let limit:Int = 10
    var playLayer:UIButton!
    var shareUrl:String!
    var timer:NSTimer?
    var settingTotalTime:Bool = false
    var leftTimerLayer:CATextLayer!
    var rightTimerLayer:CATextLayer!
    var musicModel:MusicModel!
    var image:UIImage?
    var lastIndexPath:NSIndexPath?
    
    @IBOutlet weak var musicProgressView: UIProgressView!
    
    @IBOutlet weak var activeIndicatorView: UIActivityIndicatorView!
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
        cyclePlayBtn.hidden = true
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
        
        playLayer = UIButton()
        playLayer.setBackgroundImage(UIImage(named: "musicPlayIcon"), forState: UIControlState.Normal)
        playLayer.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width / 2 - 25, 75, 60, 60)
        playLayer.addTarget(self, action: "playBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        musicView.addSubview(playLayer)
        
        leftTimerLayer = CATextLayer()
        leftTimerLayer.fontSize = 14.0
        leftTimerLayer.alignmentMode = kCAAlignmentLeft
        leftTimerLayer.contentsScale = 2.0
        leftTimerLayer.foregroundColor = UIColor.blackColor().CGColor
        leftTimerLayer.frame = CGRectMake(10, 150, 60, 15)
        self.musicView.layer.addSublayer(leftTimerLayer)
        
        rightTimerLayer = CATextLayer()
        rightTimerLayer.fontSize = 14.0
        rightTimerLayer.alignmentMode = kCAAlignmentLeft
        rightTimerLayer.contentsScale = 2.0
        rightTimerLayer.foregroundColor = UIColor.blackColor().CGColor
        rightTimerLayer.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width - 50, 150, 40, 15)
        self.musicView.layer.addSublayer(rightTimerLayer)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView(frame: CGRectZero);
        
        listBtn.selected = true
        mapBtn.selected = false
        
        tableView.addPullToRefreshWithActionHandler{ () -> Void in
            println(self.currentPage)
            self.loadingMusicDataList()
            self.currentPage++
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "closeMusicOfReceivedNotification:", name: "CloseMusicNotification", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if (mapViewController == nil){
            mapViewController = MusicMapViewController()
            mapViewController?.view.frame = CGRectMake(0, musicView.frame.origin.y,musicView.frame.size.width, musicView.frame.size.height + tableView.frame.size.height)
            mapViewController!.view.backgroundColor = UIColor.redColor()
            self.addChildViewController(mapViewController!)
            self.view.addSubview(mapViewController!.view)
            mapViewController!.view.hidden = true
            self.tableView.triggerPullToRefresh()
        }
        
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
        if musicModel != nil {
            UMSocialSnsService.presentSnsIconSheetView(self, appKey: "556a5c3e67e58e57a3003c8a", shareText: self.musicModel.musicName, shareImage: image, shareToSnsNames: [UMShareToQzone,UMShareToQQ,UMShareToSms,UMShareToWechatFavorite,UMShareToWechatSession,UMShareToWechatTimeline], delegate: self)
            UMSocialData.defaultData().extConfig.wechatSessionData.url = self.shareUrl
            UMSocialData.defaultData().extConfig.wechatTimelineData.url = self.shareUrl
            UMSocialData.defaultData().extConfig.wechatFavoriteData.url = self.shareUrl
            UMSocialData.defaultData().extConfig.qqData.url = self.shareUrl
            UMSocialData.defaultData().extConfig.qzoneData.url = self.shareUrl
        }
        else{
            self.view.makeToast("无分享数据", duration: 2.0, position: kCAGravityBottom)
        }
    }
    
    func playBtnClick(target:UIButton){
        println("click......")
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
        resetPlayMusicStatus()
        if (currentMusicIndex >= 0 && currentMusicIndex < musicList.count){
            var index1:NSIndexPath = NSIndexPath(forRow: currentMusicIndex + 1, inSection: 0)
            var cell1:MusicTableViewCell? = tableView.cellForRowAtIndexPath(index1) as? MusicTableViewCell
            cell1?.musicContentView.boardIconLayer.hidden = true
            
            var index2:NSIndexPath = NSIndexPath(forRow: currentMusicIndex, inSection: 0)
            var cell2:MusicTableViewCell? = tableView.cellForRowAtIndexPath(index2) as? MusicTableViewCell
            cell2?.musicContentView.boardIconLayer.hidden = false
            lastIndexPath = index2
            cycleAnimationFlag = true
            self.CDCycleAnimation(cdView)
            musicModel = musicList[currentMusicIndex]
            if let playing = audioStream?.isPlaying(){
                audioStream?.stop()
            }
            else if let pause = audioStream?.isPaused(){
                audioStream?.stop()
            }
            if musicModel.musicImageUrl != nil{
                initImageData(musicModel.musicImageUrl!)
            }
            shareUrl = musicModel.musicFileUrl!
            audioStream = AudioStreamer(URL: NSURL(string: musicModel.musicFileUrl!))
            audioStream?.start()
            musicNameLayer.string = musicModel.musicName
            authorNameLayer.string = musicModel.musicAuthor
            
        }
        else{
            //show Tips
             self.view.makeToast("无上一首！", duration: 1.0, position: kCAGravityBottom)
        }
    }
    
    func nextBtnClick(target:UIButton){
        currentMusicIndex++
        resetPlayMusicStatus()
        if (currentMusicIndex >= 0 && currentMusicIndex < musicList.count){
            
            var index1:NSIndexPath = NSIndexPath(forRow: currentMusicIndex - 1, inSection: 0)
            var cell1:MusicTableViewCell? = tableView.cellForRowAtIndexPath(index1) as? MusicTableViewCell
            cell1?.musicContentView.boardIconLayer.hidden = true
            
            var index2:NSIndexPath = NSIndexPath(forRow: currentMusicIndex, inSection:0)
            var cell2:MusicTableViewCell? = tableView.cellForRowAtIndexPath(index2) as? MusicTableViewCell
            cell2?.musicContentView.boardIconLayer.hidden = false
            lastIndexPath = index2
            cycleAnimationFlag = true
            self.CDCycleAnimation(cdView)
            musicModel = musicList[currentMusicIndex]
            if let playing = audioStream?.isPlaying(){
                audioStream?.stop()
            }
            else if let pause = audioStream?.isPaused(){
                audioStream?.stop()
            }
            if musicModel.musicImageUrl != nil{
                initImageData(musicModel.musicImageUrl!)
            }
            shareUrl = musicModel.musicFileUrl!
            audioStream = AudioStreamer(URL: NSURL(string: musicModel.musicFileUrl!))
            audioStream?.start()
            musicNameLayer.string = musicModel.musicName
            authorNameLayer.string = musicModel.musicAuthor
            
        }
        else{
            //show Tips
            self.view.makeToast("无下一首！", duration: 1.0, position: kCAGravityBottom)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var musicModel:MusicModel = musicList[indexPath.row]
        var cell:MusicTableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? MusicTableViewCell
        //cell?.shareBtn.center = CGPointMake(UIScreen.mainScreen().bounds.size.width - 50, 30)
        //cell?.musicContentView.frame = CGRectMake(15, 0, UIScreen.mainScreen().bounds.size.width - 100, 60)
        for view in cell!.contentView.subviews {
            if let v = view as? MusicCellView{
                cell?.musicContentView.musicAuthor = musicModel.musicAuthor!
                cell?.musicContentView.musicName = musicModel.musicName!
                cell?.musicContentView.setNeedsDisplay()
            }
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        var cell:MusicTableViewCell? = tableView.cellForRowAtIndexPath(indexPath) as? MusicTableViewCell
        cell?.musicContentView.boardIconLayer.hidden = true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (lastIndexPath != nil){
            var cell:MusicTableViewCell? = tableView.cellForRowAtIndexPath(lastIndexPath!) as? MusicTableViewCell
            cell?.musicContentView.boardIconLayer.hidden = true
        }
        
        var cell:MusicTableViewCell? = tableView.cellForRowAtIndexPath(indexPath) as? MusicTableViewCell
        cell?.musicContentView.boardIconLayer.hidden = false
        lastIndexPath = indexPath
        
        musicModel = musicList[indexPath.row]
        musicNameLayer.string = musicModel.musicName
        authorNameLayer.string = musicModel.musicAuthor
        if (musicModel.musicFileUrl != nil){
            if audioStream != nil{
                audioStream?.stop()
            }
            if musicModel.musicImageUrl != nil{
                initImageData(musicModel.musicImageUrl!)
            }
            
            var filePath:String = musicModel.musicFileUrl!
            var utfFilePath:String = filePath.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            utfFilePath = utfFilePath.stringByReplacingOccurrencesOfString(" ", withString: "")
            println(utfFilePath)
            shareUrl = musicModel.musicFileUrl!
            var url:NSURL = NSURL(string: utfFilePath)!
            audioStream = AudioStreamer(URL: url)
            audioStream?.start()
            resetPlayMusicStatus()
            currentMusicIndex = indexPath.row
            self.CDCycleAnimation(cdView)
            self.startUpdateProgressView()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func loadingMusicDataList(){
        self.activeIndicatorView.hidden = false
        self.activeIndicatorView.startAnimating()
        Alamofire.request(.GET, ServerUrl.ServerContentURL, parameters: ["content_type":"3","limit":limit,"offset":limit*(currentPage-1)])
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
                    if success == 1{
                        var articles:NSArray = dataDict?.objectForKey("articles") as! NSArray
                        if articles.count > 0{
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
                                musicModel?.latitude = tempDict.objectForKey("latitude") as! CGFloat
                                musicModel?.longitude = tempDict.objectForKey("longitude") as! CGFloat
                                musicModel?.musicDescription = tempDict.objectForKey("description") as? String
                                musicModel?.musicId = tempDict.objectForKey("id") as! Int
                                musicModel?.musicImageUrl = tempDict.objectForKey("profile") as? String
                                self.musicList.insert(musicModel!, atIndex: 0)
                                self.mapViewController?.addMapPoint(musicModel!)
                            }
                            self.tableView.reloadData()
                        }
                        else{
                            self.view.makeToast("无更多数据！")
                        }
                    }
                    else{
                        self.view.makeToast("获取数据失败！")
                    }
                }
                self.activeIndicatorView.hidden = true
                self.activeIndicatorView.stopAnimating()
                self.tableView.pullToRefreshView.stopAnimating()
        }
    }
    
    func CDCycleAnimation(cdView:UIView){
        var endAngle:CGAffineTransform = CGAffineTransformMakeRotation(cdViewAngle * CGFloat(M_PI / 180.0));
        
        UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
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
    
    func resetPlayMusicStatus(){
        musicProgressView.progress = 0.0
        settingTotalTime = false
        cdViewAngle = 1.0
        playLayer.setBackgroundImage(UIImage(named: "musicPlayIcon"), forState: UIControlState.Normal)
    }
    
    func startUpdateProgressView(){
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateProgressView", userInfo: nil, repeats:true)
        timer!.fire()
    }
    
    func updateProgressView(){
        
        if audioStream != nil{
            var totalTime = TimerStringTools().getTotleTime(audioStream!.totalTime())
            if totalTime > 0 {
                if !settingTotalTime{
                    
                    rightTimerLayer.string = (audioStream!.totalTime() as NSString).substringFromIndex(1)
                }
                settingTotalTime = true
                leftTimerLayer.string = audioStream?.currentTime()
            }
            
            var currentTime:Int = TimerStringTools().getCurrentTotleTime(audioStream!.currentTime())
            if(Double(currentTime) < audioStream!.duration)
            {
                musicProgressView.progress = Float(Double(currentTime)/audioStream!.duration)
            }
            
            if audioStream!.isFinishing(){
                leftTimerLayer.string = "00:00"
                musicProgressView.progress = 0.0
                timer!.invalidate()
            }
        }
    }
    
    func initImageData(url:String){
        let URL = NSURL(string: url)!
        let fetcher = NetworkFetcher<UIImage>(URL: URL)
            
        cache.fetch(fetcher: fetcher).onSuccess { image in
            // Do something with image
            self.image = image
        }
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("music view did disappear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func closeMusicOfReceivedNotification(notification:NSNotification){
        if audioStream != nil{
            if audioStream!.isPlaying(){
                audioStream?.stop()
            }
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "CloseMusicNotification", object: nil)
    }
}
