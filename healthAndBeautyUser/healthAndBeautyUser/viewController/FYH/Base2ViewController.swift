//
//  Base2ViewController.swift
//  PlasticSurgery
//
//  Created by RongXing on 2017/9/27.
//  Copyright © 2017年 RongXing. All rights reserved.
//

import UIKit
import DeviceKit
import MJRefresh

class Base2ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var mainTableView = UITableView()
    //    数据源
    var mainTableArr = NSMutableArray()
    
    var rightBtn = UIButton()
    
    var titleLabel = UILabel()
    var totalPage = ""
    var currentPage = 1

    var navigaView = UIView()
    
    var navHeight = 64
    let identyfierTable = "identyfierTable"
    let identyfierTable1 = "identyfierTable1"
    let identyfierTable2 = "identyfierTable2"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigaView()
        requestData()
        configSubViews()
        addHeaderRefresh()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
    }
    
    func addHeaderRefresh()  {
        
        mainTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            self.refreshHeaderAction()
        })
        
    }
    
    
    func refreshHeaderAction() {
        
    }
    
    func addFooterRefresh() {
        mainTableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            
            self.refreshFooterAction()
        })
    }
    
    func refreshFooterAction() {
        
    }

    
    func setupTitleViewSectionStyle(titleStr:String) {
        titleLabel.text = titleStr
    }
    
    func configSubViews() -> Void {
        
    }
    
    func requestData() -> Void {
        
    }

    
//    “我的” 界面需要隐藏导航栏，子控制器push和pop的时候会有空白，就重写了一个假导航栏
    func setNavigaView() {
        
        if Device() == .iPhoneX {
            navHeight = 88
        }
        
        if kSCREEN_HEIGHT == 812 {
            navHeight = 88
        }
        
        navigaView = UIView.init(frame: CGRect(x: 0, y: 0, width: Int(kSCREEN_WIDTH), height: navHeight))
        let backBtn = UIButton.init(frame: CGRect(x: 16, y: 24, width: 11, height: 20))
        backBtn.centerY = navigaView.centerY+10
        
        if Device() == .iPhoneX {
            backBtn.centerY = navigaView.centerY+20
        }
        
        if kSCREEN_HEIGHT == 812 {
            backBtn.centerY = navigaView.centerY+20
        }
        
        backBtn.setImage(#imageLiteral(resourceName: "back_icon"), for: .normal)
        backBtn.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        navigaView.addSubview(backBtn)
             
        titleLabel = UILabel.init(frame: CGRect(x: 80, y: 0, width: kSCREEN_WIDTH - 160, height: 30))
        titleLabel.centerY = backBtn.centerY
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        
        titleLabel.textColor = UIColor.black
        navigaView.addSubview(titleLabel)
        
        rightBtn = UIButton.init(frame: CGRect(x: kSCREEN_WIDTH - 60, y: 24, width: 50, height: 25))
        rightBtn.centerY = backBtn.centerY
        rightBtn.titleLabel?.textAlignment = .right
        rightBtn.addTarget(self, action: #selector(rightAction(sender:)), for: .touchUpInside)
        rightBtn.setTitleColor(kMainColor(), for: .normal)
        navigaView.addSubview(rightBtn)
        navigaView.backgroundColor = UIColor.white
        self.view.addSubview(navigaView)
        
    }
    
    public var btnTitle : String = "" {
        didSet {
            rightBtn.setTitle(btnTitle, for: .normal)
            let with = getSizeOnString(btnTitle, 20).width
            rightBtn.frame = CGRect(x: kSCREEN_WIDTH - with - 10, y: 24, width: with, height: 25)
            rightBtn.centerY = titleLabel.centerY

        }
    }
    
    public var btnImage : String = "" {
        didSet {
            rightBtn.setImage(UIImage.init(named: btnImage), for: .normal)
            
        }
    }
    
    func backAction(sender:UIButton) -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    func rightAction(sender:UIButton) -> Void {
        
    }
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

