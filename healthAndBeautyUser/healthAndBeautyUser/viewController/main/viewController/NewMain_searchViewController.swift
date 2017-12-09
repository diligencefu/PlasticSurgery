//
//  NewMain_wearchViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/21.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMain_searchViewController: Wx_baseViewController {
    let search = UITextField()
    
    let scroller = UIScrollView()
    let pageController = UIPageControl()
    
    let bottomView = UIView()
    
    //未搜索前的tableView
    lazy var rightTableView : UITableView = {
        let table1 = UITableView()
        table1.backgroundColor = backGroundColor
        table1.delegate = self
        table1.dataSource = self
        table1.separatorStyle = .none
        
        table1.register(NewMain_hotTableViewCell.self, forCellReuseIdentifier: "NewMain_hotTableViewCell")
        table1.register(NewMain_historyTableViewCell.self, forCellReuseIdentifier: "NewMain_historyTableViewCell")
        table1.register(NewMain_DeleteAllTableViewCell.self, forCellReuseIdentifier: "NewMain_DeleteAllTableViewCell")
        
        return table1
    }()
    var rightDateSource : [String] = []
    
    //搜索时的tableView
    lazy var searchTableView : UITableView = {
        let table2 = UITableView()
        table2.backgroundColor = backGroundColor
        table2.delegate = self
        table2.dataSource = self
        table2.separatorStyle = .none
        
        table2.register(NewsStoreProjectListTableViewCell.self, forCellReuseIdentifier: "NewsStoreProjectListTableViewCell")
        
        return table2
    }()
    var searchDateSource : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildData()
        buildNavi()
        buildUI()
        buildBottomView()
        rightTableView.reloadData()
    }
    
    private func buildUI() {
        
        view.backgroundColor = backGroundColor
        
        scroller.alwaysBounceHorizontal = false
        scroller.isPagingEnabled = true
        scroller.delegate = self
        scroller.bounces = false
        scroller.contentSize = CGSize.init(width: WIDTH*2, height: HEIGHT-68)
        view.addSubview(scroller)
        _ = scroller.sd_layout()?
            .topSpaceToView(view,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
        
        pageController.frame = CGRect.init(x: (WIDTH-64)/2, y: 6, width: 64, height: 12)
        pageController.numberOfPages = 2
        pageController.currentPage = 0
        pageController.pageIndicatorTintColor = UIColor.lightGray
        pageController.currentPageIndicatorTintColor = UIColor.darkGray
        view.addSubview(pageController)
        
        let titleArray = ["找项目","找产品"]
        let segmentController = UISegmentedControl(items: titleArray)
        segmentController.frame = CGRect(x:0,y:0,width:GET_SIZE * 256,height:GET_SIZE * 58)
        segmentController.tintColor = UIColor.lightGray
        segmentController.addTarget(self, action: #selector(segmentDidChangeValue(controller:)), for: .valueChanged)
        segmentController.selectedSegmentIndex = 0
        scroller.addSubview(segmentController)
        _ = segmentController.sd_layout()?
            .topSpaceToView(scroller,GET_SIZE * 49)?
            .leftSpaceToView(scroller,(WIDTH - GET_SIZE * 256)/2)?
            .widthIs(GET_SIZE * 256)?
            .heightIs(GET_SIZE * 58)
        
        let baikeView = Wx_twoTableView()
        scroller.addSubview(baikeView)
        _ = baikeView.sd_layout()?
            .topSpaceToView(segmentController,GET_SIZE * 24)?
            .leftSpaceToView(scroller,0)?
            .widthIs(WIDTH)?
            .bottomSpaceToView(scroller,0)
        baikeView.reBuildData()
        
        scroller.addSubview(self.rightTableView)
        _ = rightTableView.sd_layout()?
            .topSpaceToView(scroller,GET_SIZE * 48)?
            .leftSpaceToView(baikeView,0)?
            .widthIs(WIDTH)?
            .bottomSpaceToView(scroller,0)
    }
    
    private func buildBottomView() {
        
        bottomView.backgroundColor = backGroundColor
        view.addSubview(bottomView)
        _ = bottomView.sd_layout()?
            .topSpaceToView(scroller,0)?
            .leftSpaceToView(view,0)?
            .widthIs(WIDTH)?
            .heightIs(HEIGHT)
        
        let topView = Wx_scrollerBtnView()
        bottomView.addSubview(topView)
        _ = topView.sd_layout()?
            .topSpaceToView(bottomView,0)?
            .leftSpaceToView(bottomView,0)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 76)
        topView.btnArray = ["综合","项目","产品","日记","医生"]
        topView.scrollerViewColor = getColorWithNotAlphe(0xF1931A)
        topView.scrollerViewHeight = 3.0
        topView.btnColor = UIColor.black
        topView.buildUI()
        weak var weakSelf = self
        topView.callBackBlock { (type) in
            print(weakSelf!)
            print(type)
        }
        
    }
    
    private func buildData() {
        rightDateSource.removeAll()
        for index in 0...10 {
            rightDateSource.append("\(index)\(index)\(index)")
        }
    }
    
    private func buildNavi() {
        
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationController?.navigationBar.barTintColor = backGroundColor
        self.navigationController?.navigationBar.isTranslucent = false
        
        let searchView = UIView()
        searchView.frame = CGRect.init(x: 0, y: 20, width: WIDTH, height: 44)
        searchView.backgroundColor = backGroundColor
        navigationItem.titleView = searchView
        
        search.delegate = self
        search.borderStyle = .none
        search.placeholder = "点击即刻搜索"
        search.textColor = UIColor.black
        search.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        search.backgroundColor = UIColor.white
        searchView.addSubview(search)
        viewRadius(search, 5.0, 0.5, UIColor.black)
        search.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: GET_SIZE * 20, height: GET_SIZE * 20))
        search.leftViewMode = .always
        _ = search.sd_layout()?
            .centerYEqualToView(searchView)?
            .leftSpaceToView(searchView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 600)?
            .heightIs(GET_SIZE * 68)
        
        let cancel = UIButton()
        cancel.setTitle("取消", for: .normal)
        cancel.backgroundColor = backGroundColor
        cancel.setTitleColor(getColorWithNotAlphe(0xF1931A), for: .normal)
        cancel.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        cancel.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        searchView.addSubview(cancel)
        _ = cancel.sd_layout()?
            .leftSpaceToView(search,0)?
            .rightSpaceToView(searchView,0)?
            .topSpaceToView(searchView,0)?
            .bottomSpaceToView(searchView,0)
    }
    
    
    func segmentDidChangeValue(controller:UISegmentedControl) {
        if controller.selectedSegmentIndex == 0 {
            
        }else {
            
        }
    }
    
    @objc private func cancel(_ btn: UIButton) {
        search.resignFirstResponder()
        if search.text == "" && search.text?.characters.count == 0 {
            self.dismiss(animated: true, completion: nil)
        }else {
            bottomViewWillHide()
            search.text = ""
        }
    }
    
    var y = CGFloat()
    func bottomViewWillShow() {
        
        y = bottomView.origin.y
        weak var weakSelf = self
        UIView.animate(withDuration: 0.25) {
            var frame = weakSelf?.bottomView.frame
            frame?.origin.y = 0
            weakSelf?.bottomView.frame = frame!
        }
    }
    func bottomViewWillHide() {
        
        weak var weakSelf = self
        UIView.animate(withDuration: 0.25) {
            var frame = weakSelf?.bottomView.frame
            frame?.origin.y = (weakSelf?.y)!
            weakSelf?.bottomView.frame = frame!
        }
    }
}

// MARK: - UITableViewDelegate
extension NewMain_searchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.isEqual(rightTableView) && indexPath.section == 0 {
            return GET_SIZE * 250
        }else if tableView.isEqual(rightTableView) && indexPath.section == 1 {
            return GET_SIZE * 98
        }
        return 240
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.isEqual(rightTableView) && indexPath.section == 0 {
            var cell:NewMain_hotTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMain_hotTableViewCell") as? NewMain_hotTableViewCell
            if nil == cell {
                cell! = NewMain_hotTableViewCell.init(style: .default, reuseIdentifier: "NewMain_hotTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.model = ["定点双眼皮",
                           "外切去眼袋",
                           "内切去眼袋",
                           "玻尿酸去黑眼圈",
                           "手术去黑眼圈",
                           "种植眉毛",
                           "半永久纹眉"]
            return cell!
        }else if tableView.isEqual(rightTableView) && indexPath.section == 1 {
            if indexPath.row != rightDateSource.count - 1 {
                
                var cell:NewMain_historyTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMain_historyTableViewCell") as? NewMain_historyTableViewCell
                if nil == cell {
                    cell! = NewMain_historyTableViewCell.init(style: .default, reuseIdentifier: "NewMain_historyTableViewCell")
                }
                cell?.selectionStyle = .none
                cell?.model = rightDateSource[indexPath.row]
                return cell!
            }else {
                var cell:NewMain_DeleteAllTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMain_DeleteAllTableViewCell") as? NewMain_DeleteAllTableViewCell
                if nil == cell {
                    cell! = NewMain_DeleteAllTableViewCell.init(style: .default, reuseIdentifier: "NewMain_DeleteAllTableViewCell")
                }
                cell?.selectionStyle = .none
                return cell!
            }
        }
        var cell:NewsStoreProjectListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewsStoreProjectListTableViewCell") as? NewsStoreProjectListTableViewCell
        if nil == cell {
            cell! = NewsStoreProjectListTableViewCell.init(style: .default, reuseIdentifier: "NewsStoreProjectListTableViewCell")
        }
        cell?.selectionStyle = .none
        cell?.buildModel()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if tableView.isEqual(rightTableView) {
            let tmp = UIView()
            tmp.backgroundColor = getColorWithNotAlphe(0xEEEEEE)
            return tmp
        }else {
            return UIView()
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView.isEqual(rightTableView) {
            let tmp = UIView()
            tmp.backgroundColor = backGroundColor
            let Title = UILabel()
            Title.textColor = darkText
            Title.font = UIFont.systemFont(ofSize: GET_SIZE * 36)
            Title.textAlignment = .left
            tmp.addSubview(Title)
            _ = Title.sd_layout()?
                .centerYEqualToView(tmp)?
                .leftSpaceToView(tmp,GET_SIZE * 24)?
                .widthIs(WIDTH)?
                .heightIs(GET_SIZE * 34)
            if section == 0 {
                Title.text = "热门搜索"
            }else {
                Title.text = "历史记录"
            }
            return tmp
        } else {
            return UIView()
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView.isEqual(rightTableView) {
            return GET_SIZE * 72
        } else {
            return 0
        }
    }
}

// MARK: - UITableViewDataSource
extension NewMain_searchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.isEqual(rightTableView) {
            return 2
        }
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.isEqual(rightTableView) && section == 0 {
            return 1
        }else if tableView.isEqual(rightTableView) && section == 1 {
            return rightDateSource.count
        }
        return rightDateSource.count
    }
}


// MARK: - UIScrollViewDelegate
extension NewMain_searchViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            pageController.currentPage = 0
        }else {
            pageController.currentPage = 1
        }
    }
}

// MARK: - UITextFieldDelegate
extension NewMain_searchViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        bottomViewWillShow()
    }
}
