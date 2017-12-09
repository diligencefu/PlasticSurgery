//
//  VideoViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON
import ZFPlayer


class VideoViewController: Wx_baseViewController ,ZFPlayerDelegate,UITableViewDelegate,UITableViewDataSource{
    
    var mainTableView = UITableView()
    var mainTableArr = NSMutableArray()
    
    var playerView = ZFPlayerView()
    var currentTime = ""
    var currentIndexPath = IndexPath()
    var playM = ZFPlayerModel()
    var mdoels = [VideoModel]()
    
    var isInvalid = true
    var theCell = UITableViewCell()
    
    let identyfierTable  = "identyfierTable"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requesData()
        configSubViews()
    }
    
     func configSubViews() {
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 342;
        mainTableView.register(UINib(nibName: "VideoCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
    }
    
    func requesData() {
        
        let path = Bundle.main.path(forResource: "videoData", ofType: "json")
        let data = NSData.init(contentsOfFile: path!)
        //        let json = try! JSONSerialization.data(withJSONObject: data, options: .sortedKeys)
        
        let JSOnDictory = JSON.init(data!)
        let product_list =  JSOnDictory["videoList"].arrayValue
        
        for index in 0...product_list.count-1 {
            
            let json = product_list[index]
            let model  = VideoModel.getTheModels(json: json)
            mainTableArr.add(model)
            
        }
        
        mainTableView.reloadData()
        
    }
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainTableArr.count
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = mainTableArr[indexPath.row] as! VideoModel
        
        let cell : VideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! VideoCell
        cell.selectionStyle = .default
        cell.assin(model:model)
        
        cell.playAction = {
            
            self.playerView = ZFPlayerView.shared()
            self.playerView.delegate = self
            self.playerView.cellPlayerOnCenter = false
            
            // 当cell划出屏幕的时候停止播放
            self.playerView.stopPlayWhileCellNotVisable = false
            //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
            self.playerView.playerLayerGravity = .resizeAspectFill
            // 静音
            //             self.playerView.mute = true
            // 移除屏幕移除player
            self.playerView.stopPlayWhileCellNotVisable = true
            
            let dic = NSMutableDictionary()
            let k = JSON(model.playInfo).arrayValue
            
            for index in 0..<k.count {
                let dModel = DetailModel.getTheModels(json: k[index])
                dic.setValue(dModel.url, forKey: dModel.name)
            }
            
            _ = NSURL.init(string: dic.allValues.first as! String)
            
            let playModel = ZFPlayerModel()
            playModel.fatherViewTag = cell.pic.tag
            playModel.title         = model.title
//            playModel.videoURL      = videoURL! as URL
//            playModel.placeholderImageURLString = model.coverForFeed
            playModel.videoURL = URL.init(string: "http://120.25.226.186:32812/resources/videos/minion_01.mp4")
            playModel.placeholderImageURLString = "http://120.25.226.186:32812/resources/videos/minion_01.mp4"

            playModel.scrollView    = tableView
            playModel.indexPath     = indexPath
            self.playerView .playerControlView(nil, playerModel: playModel)
            self.playerView.hasDownload = false
            self.playerView.autoPlayTheVideo()
            
            self.playM = playModel
            self.currentIndexPath = indexPath
            self.isInvalid = false
            print($0)
            //            print(cell.frame)
            
            self.theCell = cell
            
        }
        
        //        tableView.visibleCells
        
        
        
        //        print(tableView.indexPathsForVisibleRows!)
        
        return cell
    }
    
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //        let detailVC = DetailViewController()
        //
        //        let model = mainTableArr[indexPath.section] as! VideoModel
        //
        //
        //        if indexPath == currentIndexPath {
        //            playM.seekTime = Int(playerView.currentProgress)
        //            detailVC.playModel = playM
        //            detailVC.playAction = {
        //                print($0)
        //
        //            }
        ////            detailVC.playerView = self.playerView.copy() as! ZFPlayerView
        //        }else{
        //
        //            let dic = NSMutableDictionary()
        //            let k = JSON(model.playInfo).arrayValue
        //
        //            for index in 0..<k.count {
        //                let dModel = DetailModel.getTheModels(json: k[index])
        //                dic.setValue(dModel.url, forKey: dModel.name)
        //            }
        //
        //            let videoURL = NSURL.init(string: dic.allValues.first as! String)
        //            let playModel = ZFPlayerModel()
        //            playModel.title         = model.title
        //            playModel.videoURL      = videoURL! as URL
        //            playModel.placeholderImageURLString = model.coverForFeed
        //            playModel.scrollView    = tableView
        //            playModel.indexPath     = indexPath
        //            playModel.descrip       = model.video_description
        //
        //            detailVC.playModel = playModel
        //        }
        //
        //        self.navigationController?.pushViewController(detailVC, animated: true)
        
        if (tableView.indexPathsForVisibleRows?.contains(currentIndexPath))! {
            print("属于")
        }else{
            print("不属于")
        }
        
        print(tableView.rectForRow(at: indexPath))
        
    }
    
    //    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        return UIView()
    //    }
    //
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        return UIView()
    //
    //    }
    //
    //    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 19
    //    }
    //
    //    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 0
    //    }
    //
    override func viewWillDisappear(_ animated: Bool) {
        self.playerView.resetPlayer()
    }
}

