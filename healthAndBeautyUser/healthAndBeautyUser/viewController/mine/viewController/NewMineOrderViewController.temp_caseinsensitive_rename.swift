//
//  newMineOrderViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/17.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineOrderViewController: Wx_baseViewController,UITableViewDataSource,UITableViewDelegate {
    
    let topView = wx_scrollerBtnView()
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.separatorStyle = .none
        
        table.register(newMineMessage_privateLetter_noticeTableViewCell.self, forCellReuseIdentifier: "newMineMessage_privateLetter_noticeTableViewCell")
        table.register(newMineMessage_assitTableViewCell.self, forCellReuseIdentifier: "newMineMessage_assitTableViewCell")
        table.register(newMineMessage_CommentTableViewCell.self, forCellReuseIdentifier: "newMineMessage_CommentTableViewCell")
        
        return table
    }()
    
    var modelSource : [NewMineMessageModel] = []
    var assitSource : [NewMineMessageAssitModel] = []
    var commentSource : [NewMineMessageCommentModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNaviAndOnlyBack("我的订单")
        buildUI()
    }
    
    private func buildUI() {
        
        view.backgroundColor = backGroundColor
        
        view.addSubview(topView)
        _ = topView.sd_layout()?
            .topSpaceToView(view,0)?
            .leftSpaceToView(view,0)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 86)
        
        topView.btnArray = ["全部","待付款","待使用","待写日记","退款"]
        topView.scrollerViewColor = getColorWithNotAlphe(0xF1931A)
        topView.scrollerViewHeight = 3.0
        topView.btnColor = UIColor.black
        topView.buildUI()
        topView.callBackBlock { (type) in
            self.buildData()
        }
        
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(topView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
    }
    
    //MARK : -  代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch topView.currentBtn {
        case -1,0,3,4:
            return modelSource.count
        case 1:
            return commentSource.count
        case 2:
            return assitSource.count
        default:
            break
        }
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch topView.currentBtn {
        case -1,0,3,4:
            return GET_SIZE * 128
        case 1:
            return GET_SIZE * 256
        case 2:
            return GET_SIZE * 180
        default:
            break
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch topView.currentBtn {
        case -1,0,3,4:
            var cell:newMineMessage_privateLetter_noticeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "newMineMessage_privateLetter_noticeTableViewCell") as? newMineMessage_privateLetter_noticeTableViewCell
            if nil == cell {
                cell! = newMineMessage_privateLetter_noticeTableViewCell.init(style: .default, reuseIdentifier: "newMineMessage_privateLetter_noticeTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.model = modelSource[indexPath.row]
            return cell!
        case 1:
            var cell:newMineMessage_CommentTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "newMineMessage_CommentTableViewCell") as? newMineMessage_CommentTableViewCell
            if nil == cell {
                cell! = newMineMessage_CommentTableViewCell.init(style: .default, reuseIdentifier: "newMineMessage_CommentTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.model = commentSource[indexPath.row]
            return cell!
        case 2:
            var cell:newMineMessage_assitTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "newMineMessage_assitTableViewCell") as? newMineMessage_assitTableViewCell
            if nil == cell {
                cell! = newMineMessage_assitTableViewCell.init(style: .default, reuseIdentifier: "newMineMessage_assitTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.model = assitSource[indexPath.row]
            return cell!
        default:
            break
        }
        return UITableViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
        buildData()
    }
    
    private func buildData() {
        
        switch topView.currentBtn {
        case -1,0,3,4:
            modelSource.removeAll()
            buildModel()
            break
        case 1:
            commentSource.removeAll()
            buildCommentModel()
            break
        case 2:
            assitSource.removeAll()
            buildAssitModel()
            break
        default:
            break
        }
        tableView.reloadData()
    }
    //    var modelSource : [newMineMessageModel] = []
    //    var assitSource : [newMineMessageAssitModel] = []
    //    var commentSource : [newMineMessageCommentModel] = []
    private func buildModel() {
        for _ in 0...10 {
            let model = NewMineMessageModel()
            model.head = "banner_240"
            model.name = "徐大壮"
            model.time = "5天前"
            model.detail = "commentSource : [newMineMessageCommentModel] = []"
            modelSource.append(model)
        }
    }
    private func buildAssitModel() {
        for _ in 0...10 {
            let model = NewMineMessageAssitModel()
            model.head = "banner_240"
            model.name = "张三"
            model.time = "一个月6小时前"
            model.detail = "我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁"
            assitSource.append(model)
        }
    }
    private func buildCommentModel() {
        for _ in 0...10 {
            let model = NewMineMessageCommentModel()
            model.head = "banner_240"
            model.name = "李4"
            model.time = "4小时前"
            model.detail = "我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁"
            model.repeatComment = "adfasdhjkasdjkjdsvnjknadvadlkjvb jksdbfvjhhbsdvisdvh"
            commentSource.append(model)
        }
    }
}
