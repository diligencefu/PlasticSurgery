//
//  NewMain_cityViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/22.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height
let ScreenBounds: CGRect = UIScreen.main.bounds

/// 主配色
let mainColor = UIColor.darkGray
/// 浅灰 cell背景色
let cellColor = UIColor.lightGray
/// btn 高亮背景色
let btnHighlightColor = UIColor.lightGray
/// btn 高亮图片
let btnHighlightImage = backGroundColor

/// section间距
let sectionMargin: CGFloat = 38

/// 热门城市btn
let btnMargin: CGFloat = 15
let btnWidth: CGFloat = (ScreenWidth - 90) / 3
let btnHeight: CGFloat = 36

private let nomalCell = "nomalCell"
private let hotCityCell = "hotCityCell"
private let recentCell = "rencentCityCell"
private let currentCell = "currentCityCell"

class NewMain_cityViewController: Wx_baseViewController {
    
    /// 表格
    lazy var tableView: UITableView = UITableView(frame: CGRect.init(x: 0, y: 64, width: WIDTH, height: HEIGHT-64), style: .plain)
    /// 懒加载 城市数据
    lazy var cityDic: [String: [String]] = { () -> [String : [String]] in
        let path = Bundle.main.path(forResource: "cities.plist", ofType: nil)
        let dic = NSDictionary(contentsOfFile: path ?? "") as? [String: [String]]
        return dic ?? [:]
    }()
    /// 懒加载 热门城市
    lazy var hotCities: [String] = {
        let path = Bundle.main.path(forResource: "hotCities.plist", ofType: nil)
        let array = NSArray(contentsOfFile: path ?? "") as? [String]
        return array ?? []
    }()
    /// 懒加载 标题数组
    lazy var titleArray: [String] = { () -> [String] in
        var array = [String]()
        for str in self.cityDic.keys {
            array.append(str)
        }
        // 标题排序
        array.sort()
        array.insert("热门", at: 0)
        array.insert("最近", at: 0)
        array.insert("当前", at: 0)
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        
        // 设置导航条
        createNaviController(title: "选择城市", leftBtn: buildLeftBtn(), rightBtn: nil)
        
        // 设置tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: nomalCell)
        tableView.register(RecentCitiesTableViewCell.self, forCellReuseIdentifier: recentCell)
        tableView.register(CurrentCityTableViewCell.self, forCellReuseIdentifier: currentCell)
        tableView.register(HotCityTableViewCell.self, forCellReuseIdentifier: hotCityCell)
        
        // 右边索引
        tableView.sectionIndexColor = UIColor.lightGray
        tableView.sectionIndexBackgroundColor = UIColor.clear
        self.view.addSubview(tableView)
    }
    
    deinit {
        print("我走了")
    }
}

// MARK: searchBar 代理方法
extension NewMain_cityViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
}

// MARK: tableView 代理方法、数据源方法
extension NewMain_cityViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section > 2 {
            let key = titleArray[section]
            return cityDic[key]!.count - 3
        }
        return 1
    }
    
    // MARK: 创建cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: currentCell, for: indexPath)
            cell.backgroundColor = backGroundColor
            cell.selectionStyle = .none
            return cell
            
        }else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: recentCell, for: indexPath) as! RecentCitiesTableViewCell
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: hotCityCell, for: indexPath) as! HotCityTableViewCell
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: nomalCell, for: indexPath)
            let key = titleArray[indexPath.section]
            cell.textLabel?.text = cityDic[key]![indexPath.row]
            return cell
        }
    }
    // MARK: 点击cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        let cell = tableView.cellForRow(at: indexPath)
        print("点击了 \(cell?.textLabel?.text ?? "")")
    }
    
    // MARK: 右边索引
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return titleArray
    }
    
    // MARK: section头视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: sectionMargin))
        let title = UILabel(frame: CGRect(x: 15, y: 5, width: ScreenWidth - 15, height: 28))
        var titleArr = titleArray
        titleArr[0] = "当前城市"
        titleArr[1] = "最近选择城市"
        titleArr[2] = "热门城市"
        title.text = titleArr[section]
        title.textColor = UIColor.lightGray
        title.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(title)
        view.backgroundColor = backGroundColor
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionMargin
    }
    
    // MARK: row高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return btnHeight + 2 * btnMargin
        }else if indexPath.section == 1 {
            return btnHeight + 2 * btnMargin
        }else if indexPath.section == 2 {
            let row = (hotCities.count - 1) / 3
            return (btnHeight + 2 * btnMargin) + (btnMargin + btnHeight) * CGFloat(row)
        }else{
            return 42
        }
    }
}
