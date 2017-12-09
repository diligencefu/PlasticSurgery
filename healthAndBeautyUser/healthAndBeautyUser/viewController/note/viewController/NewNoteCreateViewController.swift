//
//  NewNoteCreateViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/27.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftyJSON

//xib无法使用viewController获得控制器 就这么做一个全局吧 先放着
var isIce = false

class articleTagsAndArticleSymptomsModel: NSObject {
    
    var id = String()
    var tarContentOrSymptomInfo = String()
}

class NewNoteCreateViewController: Wx_baseViewController,
                                    UITextViewDelegate,
                                    UIImagePickerControllerDelegate,
                                    UINavigationControllerDelegate {
    
    //临时添加作为修改审核失败的日记用   屏蔽掉两个选择标签 只留下图片与文字输入即可
    //只需要搜索这个关键字即可
    var isReBuils = Bool()
    
    var noteId = String()

    //可变动属性
//    NewNoteCreateViewController
    //当前弹出页面是否是标签
    var isTag = false
    //是否冰敷 t
    var swelling = 0
    var pain = 0
    var scar = 0
    //症状
    var semeiography = [String]()
    //标签
    var tagArr = [String]()
    
//    title 日记标题
//    diaryTitle 日记本标题
//    diaryId 日记本编号
//    day   术后天数
    var titles = String()
    var diaryTitle = String()
    var diaryId = String()
    var day = String()
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var project: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var alphaView: UIView!
    
    @IBOutlet weak var selectTime: UIButton!
    @IBOutlet weak var selectType: UIButton!
    @IBOutlet weak var addTag: UILabel!
    
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var TY: UITextView!
    
    var tagData = [articleTagsAndArticleSymptomsModel]()
    var SymptomData = [articleTagsAndArticleSymptomsModel]()

    var btnArr = [UIButton]()
    var currentBtn = UIButton()
    
    //点击后弹起的tableView类型  时间0 症状1 标签类型2
    var currentTag = -1
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(clickHide))
        alphaView.addGestureRecognizer(tap)
        
        tableView.layer.cornerRadius = 10.0
        tableView.layer.masksToBounds = true
        tableView.separatorStyle = .none
        
        tableView.register(NewCreateNoteSymTabCell.self,
                           forCellReuseIdentifier: "NewCreateNoteSymTabCell")
        tableView.register(NewCreateNoteLeaveTableViewCell.self,
                           forCellReuseIdentifier: "NewCreateNoteLeaveTableViewCell")
        tableView.register(NewCreateNoteSymptomTabCell.self,
                           forCellReuseIdentifier: "NewCreateNoteSymptomTabCell")
        tableView.register(UINib.init(nibName: "NewCreateNoteTimeTabCell", bundle: nil),
                           forCellReuseIdentifier: "NewCreateNoteTimeTabCell")
        tableView.register(UINib.init(nibName: "NewCreateNoteLevelTabCell", bundle: nil),
                           forCellReuseIdentifier: "NewCreateNoteLevelTabCell")
        
        view.bringSubview(toFront: alphaView)
        view.bringSubview(toFront: tableView)
        
        SVPWillShow("载入中...")
        
//        构建主数据
        buildData()
//        19.日记标签信息接口
        articleTags()
//        20.日记症状信息接口
        articleSymptoms()
        
        //修改页面属性与状态
        if isReBuils {
            createNaviController(title: "修改日记",
                                 leftBtn: buildLeftBtn(),
                                 rightBtn: buildRightBtnWithName("发布"))
            
            //获得时间数据
            let calendar: Calendar = Calendar(identifier: .gregorian)
            var comps: DateComponents = DateComponents()
            comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
            let dateStr = "\(comps.year!)-\(comps.month!)-\(comps.day!)"
            
            //更新界面UI
            DispatchQueue.main.async {
                
                self.time.text = dateStr
                self.project.text = self.diaryTitle
                self.selectTime.setTitle(self.titles, for: .normal)
            }
        }else {
            createNaviController(title: "写日记",
                                 leftBtn: buildLeftBtn(),
                                 rightBtn: buildRightBtnWithName("发表"))
        }
    }
    
    private func buildData() {
        
        if isReBuils {
            // 数据从前一个页面带入
            return
        }
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":noteId]
            as [String: Any]
        delog(up)
        
        Net.share.getRequest(urlString: CBBArticleInfoJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            if json["code"].int == 1 {
                
                let data = json["data"]
                //需求的数据
                self.titles = data["title"].string!
                self.diaryTitle = data["diaryTitle"].string!
                self.diaryId = data["diaryId"].string!
                self.day = "\(data["day"].int!)"
                
                //获得时间数据
                let calendar: Calendar = Calendar(identifier: .gregorian)
                var comps: DateComponents = DateComponents()
                comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
                let dateStr = "\(comps.year!)-\(comps.month!)-\(comps.day!)"
                //更新界面UI
                DispatchQueue.main.async {
            
                    self.time.text = dateStr
                    self.project.text = self.diaryTitle
                    self.selectTime.setTitle(self.titles, for: .normal)
                }
                self.refreshList()
            }
        }) { (error) in
            delog(error)
        }
    }
    private func articleTags() {
        
        Net.share.getRequest(urlString: CBBArticleTagsJoggle, params: nil, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            if json["code"].int == 1 {
                
                self.tagData.removeAll()
                let data = json["data"]
                for (_, subJson):(String, JSON) in data["tags"] {
                    
                    let model = articleTagsAndArticleSymptomsModel()
                    model.id = subJson["id"].string!
                    model.tarContentOrSymptomInfo = subJson["tarContent"].string!
                    self.tagData.append(model)
                }
                self.refreshList()
            }
        }) { (error) in
            delog(error)
        }
    }
    
    private func articleSymptoms() {
        
        Net.share.getRequest(urlString: CBBArticleSymptomsJoggle, params: nil, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            if json["code"].int == 1 {
                
                self.SymptomData.removeAll()
                let data = json["data"]
                for (_, subJson):(String, JSON) in data["symptoms"] {
                    
                    let model = articleTagsAndArticleSymptomsModel()
                    model.id = subJson["id"].string!
                    model.tarContentOrSymptomInfo = subJson["symptomInfo"].string!
                    self.SymptomData.append(model)
                }
                self.refreshList()
            }
        }) { (error) in
            delog(error)
        }
    }
    
    //查看所有数据是否刷新完毕
    private func refreshList() {
        
        //3条数据全部刷新完
        if SymptomData.count != 0 && tagData.count != 0 && titles.characters.count != 0{
            SVPHide()
            tableView.reloadData()
        }
    }
    
    @IBAction func click(_ sender: UIButton) {
        
        if isReBuils {
            delog("审核失败日志编辑页面 不触发点击方法")
            SVPwillShowAndHide("编辑审核失败日志，无法修改该内容")
            return
        }
        
        switch sender.tag {
            
        case 666://选择时间
            //无法点击
            break
        case 667://选择症状
            isTag = false
            currentTag = sender.tag - 666
            bottomViewWillShow()
            tableView.reloadData()
            break
        case 668://添加标签
            isTag = true
            currentTag = sender.tag - 666
            bottomViewWillShow()
            tableView.reloadData()
            break
        default:
            break
        }
    }
    
    @objc private func clickHide() {
        bottomViewWillHide()
    }
    
    fileprivate func bottomViewWillShow() {
        
        UIView.animate(withDuration: 0.25) {
            
            self.alphaView.alpha = 0.35
            
            var frame = self.tableView.frame
            if self.currentTag == 0 {
                frame.origin.y = HEIGHT - GET_SIZE * 800
                frame.size.height = GET_SIZE * 820
            }else if self.currentTag == 1 {
                frame.origin.y = HEIGHT - GET_SIZE * 900
                frame.size.height = GET_SIZE * 920
            }else {
                frame.origin.y = HEIGHT - GET_SIZE * 400
                frame.size.height = GET_SIZE * 400
            }
            self.tableView.frame = frame
        }
    }
    
    @objc fileprivate func bottomViewWillHide() {
        
        UIView.animate(withDuration: 0.25) {
            
            self.alphaView.alpha = 0
            
            var frame = self.tableView.frame
            if self.currentTag == 0 {
                frame.origin.y = HEIGHT
                frame.size.height = 0
            }else if self.currentTag == 1 {
                frame.origin.y = HEIGHT
                frame.size.height = 0
            }else {
                frame.origin.y = HEIGHT
                frame.size.height = 0
            }
            self.tableView.frame = frame
        }
    }
    
    //弹起页面点击完成
    @objc fileprivate func clickOver() {
        
        
        bottomViewWillHide()
    }
    
    //页面完全出现后构建
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //图片选择框
        scroller.contentSize = CGSize.init(width: 120 * 6 + 14 * (6 + 1), height: scroller.height)
        
        for index in 0..<6 {
            
            let btn = UIButton()
            btn.setImage(UIImage(named:"add_icon_default"), for: .normal)
            btn.tag = 400+index
            btn.addTarget(self, action: #selector(clickSelectIMG(_:)), for: .touchUpInside)
            viewRadius(btn, 5.0, 0.5, lineColor)
            scroller.addSubview(btn)
            _ = btn.sd_layout()?
                .centerYEqualToView(scroller)?
                .leftSpaceToView(scroller, CGFloat(120 * index + 14 * (index + 1)))?
                .widthIs(120)?
                .heightIs(scroller.height - 32)
            if index != 0 {
                btn.isHidden = true
            }
            btnArr.append(btn)
        }
    }
    
    @objc private func clickSelectIMG(_ btn: UIButton) {
        
        //获取当前按钮
        currentBtn = btn
        showImage()
    }
    
    // MARK: - 图片选择逻辑
    func showImage() {
        
        let alertController = UIAlertController.init(title: "",
                                                     message: "照片选择方式",
                                                     preferredStyle: .actionSheet)
        let camera = UIAlertAction.init(title: "相机",
                                        style: .default,
                                        handler: { (action) in
                                            self.getCamera()
        })
        let photoBook = UIAlertAction.init(title: "相册",
                                           style: .default,
                                           handler: { (action) in
                                            self.getPhoto()
        })
        let cancel = UIAlertAction.init(title: "取消",
                                        style: .cancel,
                                        handler: { (action) in
                                            
        })
        alertController.addAction(camera)
        alertController.addAction(photoBook)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //调用照片方法
    func getPhoto(){
        let pick:UIImagePickerController = UIImagePickerController()
        pick.delegate = self
        pick.allowsEditing = true//设置可编辑
        pick.sourceType = UIImagePickerControllerSourceType.photoLibrary
        DispatchQueue.main.async {
            self.present(pick, animated: true, completion: nil)
        }
    }
    
    //调用照相机方法
    func getCamera(){
        let pick:UIImagePickerController = UIImagePickerController()
        pick.delegate = self
        pick.allowsEditing = true//设置可编辑
        pick.sourceType = UIImagePickerControllerSourceType.camera
        DispatchQueue.main.async {
            self.present(pick, animated: true, completion: nil)
        }
    }
    
    //定义两个图片获取方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.dismiss(animated: true, completion: nil)

        //设置该图片的图片 并且设置已选中
        currentBtn.setImage((info[UIImagePickerControllerEditedImage] as? UIImage)!, for: .normal)
        currentBtn.imageView?.contentMode = .scaleAspectFill
        currentBtn.isSelected = true
        
        //如果不是最后一张 那么就需要显示下一张图片的可点击
        if currentBtn.tag != 405 {
            let btn = view.viewWithTag(currentBtn.tag + 1) as! UIButton
            btn.isHidden = false
        }
        
        if currentBtn.tag != 400 {
            //滑动图片选择栏
            scroller.setContentOffset(CGPoint.init(x: currentBtn.origin.x-60, y: 0), animated: true)
        }
    }
    
    override func rightClick() {
        
        if isReBuils {
            delog("审核失败重新发布")
            reviewedPush()
            return
        }
        
        if swelling == 0 {
            SVPwillShowAndHide("请选择肿胀程度")
            return
        }else if pain == 0{
            SVPwillShowAndHide("请选择疼痛程度")
            return
        }else if scar == 0{
            SVPwillShowAndHide("请选择疤痕程度")
            return
        }
        
        if !(btnArr.first?.isSelected)! {
            SVPwillShowAndHide("请确认您是否上传图片")
            return
        }
        
        if TY.text == "写日记分享变美过程，还有机会获得日记奖励哦" {
            SVPwillShowAndHide("请输入具体日记文本")
            return
        }
        
        if semeiography.count == 0 {
            SVPwillShowAndHide("您最少需要选择一个症状记录")
            return
        }
        
        if tagArr.count == 0 {
            SVPwillShowAndHide("您最少需要选择一个标签记录")
            return
        }
        
        var semeiographyText = String()
        for index in semeiography {
            if index != semeiography.last {
                semeiographyText += "\(index),"
            }else {
                semeiographyText += index
            }
        }
        
        var tagText = String()
        for index in tagArr {
            if index != tagArr.last {
                tagText += "\(index),"
            }else {
                tagText += index
            }
        }
        
        var up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "semeiography":semeiographyText,
                  "title":titles,
                  "content":TY.text!,
                  "day":day,
                  "diaryId":diaryId,
                  "pain":"\(pain)",
                  "scar":"\(scar)",
                  "swelling":"\(swelling)",
                  "ids":tagText]
            as [String: String]
        
        if isIce {
            up["isIce"] = "0"
        }else {
            up["isIce"] = "1"
        }
        
        var imgArr = [UIImage]()
        var nameArr = [String]()

        for index in 0..<btnArr.count {
            if btnArr[index].isSelected {
                imgArr.append((btnArr[index].imageView?.image)!)
                nameArr.append("image\(index)")
            }
        }
        
        delog(up)
        SVPWillShow("载入中...")
        
        Net.share.createNoteUpLoadImageRequest(urlString: CBBCreateArticleJoggle,
                                     params: up,
                                     data: imgArr,
                                     name: nameArr,
                                     success: { (datas) in
                                        let json = JSON(datas)
                                        delog(json)
                                        SVPHide()
                                        if json["code"].int == 1 {
                                            SVPwillSuccessShowAndHide("创建日记成功")
                                            self.navigationController?.popViewController(animated: true)
                                        }else {
                                            SVPwillShowAndHide(json["message"].string!)
                                        }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("网络连接失败!")
        }
    }
    
    private func reviewedPush() {
        
        if !(btnArr.first?.isSelected)! {
            SVPwillShowAndHide("请确认您是否上传图片")
            return
        }
        
        if TY.text == "写日记分享变美过程，还有机会获得日记奖励哦" {
            SVPwillShowAndHide("请输入具体日记文本")
            return
        }
        
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "content":TY.text!,
                  "id":noteId]
            as [String: String]
        
        var imgArr = [UIImage]()
        var nameArr = [String]()
        
        for index in 0..<btnArr.count {
            if btnArr[index].isSelected {
                imgArr.append((btnArr[index].imageView?.image)!)
                nameArr.append("image\(index)")
            }
        }
        
        delog(up)
        SVPWillShow("载入中...")
        
        Net.share.rePushNoteUpLoadImageRequest(urlString: CBBUpdateArticleJoggle,
                                               params: up,
                                               data: imgArr,
                                               name: nameArr,
                                               success: { (datas) in
                                                let json = JSON(datas)
                                                delog(json)
                                                SVPHide()
                                                if json["code"].int == 1 {
                                                    SVPwillSuccessShowAndHide("重新编辑日记成功")
                                                    self.navigationController?.popToRootViewController(animated: true)
                                                }else {
                                                    SVPwillShowAndHide(json["message"].string!)
                                                }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("网络连接失败!")
        }
    }
}

extension NewNoteCreateViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if currentTag == 0 {
            
        }else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if currentTag == 0 {
            return GET_SIZE * 88
        }else if currentTag == 1 {
            if indexPath.section == 0 {
                return GET_SIZE * 388
            }else {
                return GET_SIZE * 88
            }
        }else {
            return GET_SIZE * 276
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentTag == 1 {
            if indexPath.section == 0 {
                var cell:NewCreateNoteSymptomTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewCreateNoteSymptomTabCell") as? NewCreateNoteSymptomTabCell
                if nil == cell {
                    cell! = NewCreateNoteSymptomTabCell.init(style: .default,
                                                             reuseIdentifier: "NewCreateNoteSymptomTabCell")
                }
                cell?.selectionStyle = .none
                cell?.symptoms = SymptomData
                return cell!
            }else {
                if indexPath.row < 3 {
                    var cell:NewCreateNoteLeaveTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewCreateNoteLeaveTableViewCell") as? NewCreateNoteLeaveTableViewCell
                    if nil == cell {
                        cell! = NewCreateNoteLeaveTableViewCell.init(style: .default,
                                                                 reuseIdentifier: "NewCreateNoteLeaveTableViewCell")
                    }
                    cell?.selectionStyle = .none
                    if indexPath.row == 0 {
                        cell?.model = swelling_pain_car.swelling
                    }else if indexPath.row == 1 {
                        cell?.model = swelling_pain_car.pain
                    }else {
                        cell?.model = swelling_pain_car.scar
                    }
                    return cell!
                }
                let cell : NewCreateNoteLevelTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewCreateNoteLevelTabCell", for: indexPath) as? NewCreateNoteLevelTabCell
                return cell!
            }
        }else {
            var cell:NewCreateNoteSymTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewCreateNoteSymTabCell") as? NewCreateNoteSymTabCell
            if nil == cell {
                cell! = NewCreateNoteSymTabCell.init(style: .default,
                                                         reuseIdentifier: "NewCreateNoteSymTabCell")
            }
            cell?.selectionStyle = .none
            cell?.model = tagData
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var sizes = CGSize()
        
        let header = UIView()
        header.backgroundColor = UIColor.white
        header.frame = CGRect.init(x: 0, y: 0, width: WIDTH, height: GET_SIZE * 88)
        
        let title = UILabel()
        title.textColor = darkText
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: GET_SIZE * 36)
        header.addSubview(title)
        if currentTag == 0 {
            title.text = "术后天数"
        }else if currentTag == 1 {
            title.text = "症状记录"
        }else {
            title.text = "添加标签"
        }
        sizes = getSizeOnLabel(title)
        _ = title.sd_layout()?
            .centerYEqualToView(header)?
            .centerXEqualToView(header)?
            .widthIs(sizes.width)?
            .heightIs(sizes.height)
        
        if currentTag == 0 {
            return header
        }
        
        let cancel = UIButton.init()
        cancel.setImage(UIImage(named:"close_icon_default"), for: .normal)
        cancel.addTarget(self, action: #selector(bottomViewWillHide), for: .touchUpInside)
        cancel.frame = CGRect.init(x: 0, y: 0, width: GET_SIZE * 88, height: GET_SIZE * 98)
        header.addSubview(cancel)
        
        let over = UIButton()
        over.setTitle("完成", for: .normal)
        over.setTitleColor(tabbarColor, for: .normal)
        over.addTarget(self, action: #selector(clickOver), for: .touchUpInside)
        sizes = getSizeOnLabel(over.titleLabel!)
        header.addSubview(over)
        _ = over.sd_layout()?
            .centerYEqualToView(header)?
            .rightSpaceToView(header,12)?
            .widthIs(sizes.width)?
            .heightIs(GET_SIZE * 98)
        
        let line = UIView()
        line.backgroundColor = lineColor
        header.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(header,0)?
            .rightSpaceToView(header,0)?
            .widthIs(WIDTH)?
            .heightIs(1)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if currentTag == 1 && section == 1{
            return 0
        }
        return GET_SIZE * 98
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footer = UIView()
        footer.backgroundColor = UIColor.white
        
        if currentTag == 0 {
            let over = UIButton()
            over.setTitle("取消", for: .normal)
            over.setTitleColor(tabbarColor, for: .normal)
            over.addTarget(self, action: #selector(bottomViewWillHide), for: .touchUpInside)
            over.frame = CGRect.init(x: 0, y: 0, width: WIDTH, height: GET_SIZE * 88)
            footer.addSubview(over)
            return footer
        }else if currentTag == 1 {
            
            return footer
        }else {
            let line = UIView()
            line.backgroundColor = lineColor
            line.frame = CGRect.init(x: 0, y: 0, width: WIDTH, height: 1)
            footer.addSubview(line)
            return footer
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if currentTag == 1 && section == 0{
            return 0
        }
        if currentTag == 2{
            return 0
        }
        return GET_SIZE * 80
    }
}

extension NewNoteCreateViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if currentTag == -1 {
            return 0
        }
        if currentTag == 0 {
            return 1
        }else if currentTag == 1 {
            return 2
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentTag == -1 {
            return 0
        }
        if currentTag == 1 {
            if section == 0 {
                return 1
            }
            return 4
        }else {
            return 1
        }
    }
}

extension NewNoteCreateViewController {
    
    // MARK: - 键盘效果逻辑
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(center:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(center:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        IQKeyboardManager.sharedManager().enable = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        IQKeyboardManager.sharedManager().enable = true
    }
    
    //点击屏幕收回键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //完成收回键盘
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "写日记分享变美过程，还有机会获得日记奖励哦" {
            textView.text = ""
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "写日记分享变美过程，还有机会获得日记奖励哦"
        }
        view.endEditing(true)
    }
    
    func keyboardWillShow(center:Notification) -> Bool {
        
        let dic:NSDictionary = center.userInfo! as NSDictionary
        let keyBoard:AnyObject? = dic.object(forKey: UIKeyboardFrameEndUserInfoKey) as AnyObject?
        let endY = keyBoard?.cgRectValue.size.height
        
        var keyBoardRect = self.view.frame
        keyBoardRect.origin.y = -endY!/2
        self.view.frame = keyBoardRect
        return true
    }
    
    func keyboardWillHide(center:Notification) -> Bool {
        
        var keyBoardRect = self.view.frame
        keyBoardRect.origin.y = 0
        self.view.frame = keyBoardRect
        return true
    }
}
