//
//  WXSelectView.swift
//  WXselectPopModule
//
//  Created by  on 2017/9/16.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class WXSelectView: UIView {
    
    //返回的值 是当前点击选中的字符串  当前是第几个分组  该分组的第几个选项
    typealias swiftBlock = (_ str:String, _ num:NSInteger , _ row: NSInteger) -> Void
    var willClick : swiftBlock? = nil
    func didChangeValue(block: @escaping (_ str:String, _ num:NSInteger , _ row: NSInteger) -> Void ) {
        willClick = block
    }
    
    public var type = selectVar()
    
    //MARK: - 私有变量          初始化方法
    private lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(WXSelectTabCell.self, forCellReuseIdentifier: "WXSelectTabCell")
        
        return table
    }()
    
    fileprivate var dataSource = [selectModel]()
    fileprivate var selectIndex = [NSInteger]()

    fileprivate var btnArr = [UIButton]()
    fileprivate var imgArr = [UIImageView]()
    
    fileprivate var currentIndex = NSInteger()
    fileprivate var currentIMG = UIImageView()
    
    fileprivate var selfHeight = CGFloat()
    fileprivate var selfWIDTH = CGFloat()
    
    fileprivate let baikeView = Wx_twoTableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        //这里应该首先初始化后 设置尺寸 再调用 buildBaseUI（）
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - function
    public func buildBaseUI() {
        
        buildTab()
        backgroundColor = backGroundColor
        selectIndex.removeAll()
        selfHeight = self.frame.height
        selfWIDTH = self.frame.width

        //默认设置全选0
        for _ in 0..<type.source!.count {
            selectIndex.append(-1)
        }
        let count = type.source!.count
        let width = Int(WIDTH) / count
        
        for index in 0..<count {
            
            let arr = type.source?[index]
            let btn = UIButton()
            btn.frame = CGRect.init(x: width * index,
                                    y: 0,
                                    width: width,
                                    height: Int(selfHeight))
            btn.backgroundColor = backGroundColor
            btn.setTitle(arr?[0] as? String, for: .normal)
            btn.setTitleColor(type.unSelectColor, for: .normal)
            btn.titleLabel?.font = type.mainFont
            btn.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
            self.addSubview(btn)
            btnArr.append(btn)
            
            let img = UIImageView()
            img.image = type.isSelectIMG
            img.isUserInteractionEnabled = true
            img.frame = CGRect.init(x: btn.frame.size.width - GET_SIZE * 28 * 2 ,
                                    y: (selfHeight - GET_SIZE * 14) / 2,
                                    width: GET_SIZE * 28,
                                    height: GET_SIZE * 14)
            btn.addSubview(img)
            imgArr.append(img)

            btn.tag = 400 + index
            img.tag = 500 + index
            
            if index == count - 1 {
                break
            }
            let line = UIView()
            line.backgroundColor = lineColor
            line.frame = CGRect.init(x: btn.frame.size.width - 0.5,
                                     y: (selfHeight - GET_SIZE * 36) / 2,
                                     width: 0.5,
                                     height: GET_SIZE * 36)
            btn.addSubview(line)
        }
        
        let line = UIView()
        line.backgroundColor = lineColor
        line.frame = CGRect.init(x: 0,
                                 y: selfHeight-1,
                                 width: selfWIDTH,
                                 height: 1)
        self.addSubview(line)
    }
    
    private func buildTab() {
        
        tableView.frame = CGRect.init(x: 0,
                                      y: 0,
                                      width:WIDTH,
                                      height: selfHeight)
        self.addSubview(tableView)
        
        baikeView.frame = CGRect.init(x: 0,
                                      y: 0,
                                      width:WIDTH,
                                      height: selfHeight)
        self.addSubview(baikeView)
        weak var weakSelf = self
        
        baikeView.callBackBlock { (id, name) in
            
            // 获得当前选项的按钮
            let btn = weakSelf?.viewWithTag(400 + (weakSelf?.currentIndex)!) as! UIButton
            btn.setTitle(name, for: .normal)
            weakSelf?.hideTableView()
        }
    }
    
    // MARK: - 逻辑
    @objc private func click(_ btn: UIButton) {
        
        //点击变色处理
        for index in btnArr {
            index.setTitleColor(type.unSelectColor, for: .normal)
        }
        btn.setTitleColor(type.selectColor, for: .normal)
        
        //获得该选项的图像
        let img = viewWithTag(btn.tag + 100) as! UIImageView
        
        if btn.tag == 0 {
            
            UIView.animate(withDuration: 0.25, animations: {
                
                //即将出现的点击区域的可点击cell数量
                self.type.cellShowNumber = 5
                
                //self点击区域
                var frame1 = self.frame
                frame1.size.height = CGFloat(self.type.cellShowNumber! + 1) * self.selfHeight
                self.frame = frame1
                
                //table区域
                var frame2 = self.baikeView.frame
                frame2.size.height = CGFloat(self.type.cellShowNumber!) * self.selfHeight
                frame2.origin.y = self.selfHeight
                self.tableView.frame = frame2
                
                //img旋转
                for index in self.imgArr {
                    index.transform = CGAffineTransform.identity
                }
                img.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            })
            return
        }
        
        //获得当前点击的序号
        //数组设置
        currentIndex = btn.tag - 400
        dataSource.removeAll()
        for index in 0..<(type.source?[currentIndex].count)! {
            
            let model = selectModel()
            model.title = type.source?[currentIndex][index] as! String
            if index == selectIndex[currentIndex] {
                model.isSelect = true
            }
            dataSource.append(model)
        }
        //数组第一个为类型
        dataSource.removeFirst()
        tableView.reloadData()
        if selectIndex[currentIndex] != -1 {
            tableView.selectRow(at: IndexPath.init(row: selectIndex[currentIndex], section: 0), animated: true, scrollPosition: .none)
        }
        UIView.animate(withDuration: 0.25, animations: {
            
            //即将出现的点击区域的可点击cell数量
            if self.dataSource.count < 5 {
                self.type.cellShowNumber = self.dataSource.count
            }else {
                self.type.cellShowNumber = 5
            }
            //self点击区域
            var frame1 = self.frame
            frame1.size.height = CGFloat(self.type.cellShowNumber! + 1) * self.selfHeight
            self.frame = frame1
            
            //table区域
            var frame2 = self.frame
            frame2.size.height = CGFloat(self.type.cellShowNumber!) * self.selfHeight
            frame2.origin.y = self.selfHeight
            self.tableView.frame = frame2

            //img旋转
            for index in self.imgArr {
                index.transform = CGAffineTransform.identity
            }
            img.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }) { (nil) in
        }
    }
    
    func hideTableView() {
        
        //点击变色处理
        for index in btnArr {
            index.setTitleColor(type.unSelectColor, for: .normal)
        }
        
        UIView.animate(withDuration: 0.3) {
            
            var frame = self.frame
            frame.size.height = self.selfHeight
            frame.origin.y = 64
            self.frame = frame
            
            frame.origin.y = 0
            self.tableView.frame = frame
            
            //img旋转
            for index in self.imgArr {
                index.transform = CGAffineTransform.identity
            }
        }
    }
}

extension WXSelectView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 获得当前选项的按钮
        let btn = viewWithTag(400 + currentIndex) as! UIButton
        btn.setTitle(dataSource[indexPath.row].title, for: .normal)
        //设置当前按钮的值
        selectIndex[currentIndex] = indexPath.row
        hideTableView()
        if willClick != nil {
            willClick!(dataSource[indexPath.row].title, currentIndex, indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.selfHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:WXSelectTabCell? = tableView.dequeueReusableCell(withIdentifier: "WXSelectTabCell")
                                                as? WXSelectTabCell
        if nil == cell {
            cell! = WXSelectTabCell.init(style: .default,
                                         reuseIdentifier: "WXSelectTabCell")
        }
        cell?.selectionStyle = .none
        cell?.model = dataSource[indexPath.row]
        return cell!
    }
}

extension WXSelectView : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}
