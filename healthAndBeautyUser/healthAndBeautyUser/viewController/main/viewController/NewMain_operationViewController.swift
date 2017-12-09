//
//  NewMain_operationViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/23.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import ZFPlayer
import DZNEmptyDataSet

var NewMain_operationViewController_dateSource : [NewOperationModel] = []
class NewMain_operationViewController: Wx_baseViewController,ZFPlayerDelegate {
    
    lazy var tableView : UITableView = {
        
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.emptyDataSetSource = self
        table.emptyDataSetDelegate = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(UINib.init(nibName: "NewOperationTableViewCell", bundle: nil), forCellReuseIdentifier: "NewOperationTableViewCell")
        
        return table
    }()
    
    var player = ZFPlayerView.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "手术动态", leftBtn: buildLeftBtn(), rightBtn: nil)
        buildUI()
    }
    
    private func buildUI() {
        
        player?.delegate = self
        player?.stopPlayWhileCellNotVisable = true
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(naviView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        buildData()
    }
    
    private func buildData() {
        
        var up = [:]
            as [String : Any]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: getOperations__joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                NewMain_operationViewController_dateSource.removeAll()
                for (_, subJson):(String,JSON) in json["data"]["operationItems"] {
                    
                    let model = NewOperationModel()
                    model.id = subJson["id"].string!
                    model.hits = subJson["hits"].int!
                    model.content = subJson["content"].string!
                    model.rewards = subJson["rewards"].int!
                    model.video = subJson["video"].string!
                    model.thumbs = subJson["thumbs"].int!
                    model.comments = subJson["comments"].int!
                    model.title = subJson["title"].string!
                    model.createDate = subJson["createDate"].string!
                    model.path = json["data"]["path"].string!
                    
                    model.bespoke = subJson["doctor"]["bespoke"].int!
                    model.currentPosition = subJson["doctor"]["currentPosition"].string!
                    model.cases = subJson["doctor"]["cases"].int!
                    model.doctorName = subJson["doctor"]["doctorName"].string!
                    model.sex = subJson["doctor"]["sex"].string!
                    model.headImage = subJson["doctor"]["headImage"].string!
                    NewMain_operationViewController_dateSource.append(model)
                }
                self.tableView.reloadData()
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.resetPlayer()
    }
}

// MARK: - UITableViewDelegate


extension NewMain_operationViewController: UITableViewDelegate {
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        

        
//        }
        
//        delog(tableView.rectForRow(at: indexPath).minY)
//        delog(tableView.rectForRow(at: indexPath).maxY)
//        delog(tableView.contentOffset.y)
//
//
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let sizes = getSizeOnString(NewMain_operationViewController_dateSource[indexPath.row].content, 14)
        let content = sizes.height > 44 ? 44 : sizes.height
        return 280 + content
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:NewOperationTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewOperationTableViewCell") as? NewOperationTableViewCell
        cell?.selectionStyle = .none
        cell?.model = indexPath
        
        weak var weakSelf = self
        cell?.willClick(block: { (isPlayer) in
            if isPlayer {
                
                let model = ZFPlayerModel()
                delog(NewMain_operationViewController_dateSource[indexPath.row].path + NewMain_operationViewController_dateSource[indexPath.row].video)
//                model.videoURL = StringToUTF_8InUrl(str: NewMain_operationViewController_dateSource[indexPath.row].path + NewMain_operationViewController_dateSource[indexPath.row].video)
//                model.placeholderImageURLString = NewMain_operationViewController_dateSource[indexPath.row].path + NewMain_operationViewController_dateSource[indexPath.row].video
                model.videoURL = StringToUTF_8InUrl(str: "http://120.25.226.186:32812/resources/videos/minion_01.mp4")
                model.placeholderImageURLString = "http://120.25.226.186:32812/resources/videos/minion_01.mp4"
                
//                        [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
                model.scrollView = tableView
                model.indexPath = indexPath
                model.fatherViewTag = cell!.img.tag
                weakSelf?.player?.playerControlView(nil, playerModel: model)
                weakSelf?.player?.hasDownload = false
                weakSelf?.player?.autoPlayTheVideo()
            }
        })
        return cell!
    }
}

// MARK: - UITableViewDataSource

extension NewMain_operationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewMain_operationViewController_dateSource.count
    }
}

// MARK: -
extension NewMain_operationViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        
        return UIImage(named:"no-data_icon")
    }
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let titles = "没有数据"
        let attributs = [NSFontAttributeName:UIFont.systemFont(ofSize: 16),
                         NSForegroundColorAttributeName:darkText]
        return NSAttributedString.init(string: titles, attributes: attributs)
    }
    
}
