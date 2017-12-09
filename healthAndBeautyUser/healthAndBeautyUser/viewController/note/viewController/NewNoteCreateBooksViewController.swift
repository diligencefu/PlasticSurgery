//
//  NewNoteCreateBooksViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/19.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class NewNoteCreateBooksViewController: Wx_baseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var head: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var sex: UIImageView!
    
    //取消时间选择
//    @IBOutlet weak var date: UILabel!
//    @IBOutlet weak var week: UILabel!
    
    @IBOutlet weak var project: UILabel!
    @IBOutlet weak var product: UILabel!
    @IBOutlet weak var doctor: UILabel!
    
    @IBOutlet weak var img1: UIButton!
    @IBOutlet weak var img2: UIButton!
    @IBOutlet weak var img3: UIButton!
    
    @IBAction func click(_ sender: UIButton) {
        
        delog(sender.tag)
        currentTag = sender.tag
        switch sender.tag {
        case 667://修改日期//废弃
//            selectDate()
            break
//        case 668://选择项目//废弃
//            navigationController?.pushViewController(NewNoteSelectProjectViewController(), animated: true)
//            break
        case 669://选择订单
            navigationController?.pushViewController(NewNoteSelectOrderViewController(), animated: true)
            break
        case 700,701,702://图片选择
            showImage()
            break
        default:
            break
        }
    }
    
    private var currentTag = NSInteger()
    
    //创建日记本需要的数据
    private var completeDate = String()
    private var productId = String()
    private var orderId = String()
    private var projectName = String()
    private var projectId = String()
    private var titles = String()
    private var ids = String()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        createNaviController(title: "创建日记本",
                             leftBtn: buildLeftBtn(),
                             rightBtn: buildRightBtnWithName("完成"))
        
        //刷新数据
        SelectOrderId = String()
        
//        buildDay()//废弃
        
        head.contentMode = .scaleAspectFill
        head.layer.cornerRadius = 49/2
        head.layer.masksToBounds = true
        head.layer.borderWidth = 0.5
        head.layer.borderColor = lightText.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        buildData()
    }
    
    override func rightClick() {
        
        if img1.isSelected && img2.isSelected && img3.isSelected {
            delog("确认已插入图片")
        }else {
            SVPwillShowAndHide("请输入缺失的图片")
            return
        }
        
        if SelectOrderId.characters.count == 0 {
            SVPwillShowAndHide("请选择订单")
            return
        }else {
            delog("确认已选择订单")
        }
        
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "completeDate":completeDate,
                  "productId":productId,
                  "orderId":orderId,
                  "projectName":projectName,
                  "projectId":projectId,
                  "title":titles,
                  "ids":ids]
            as [String: String]
        
        delog(up)
        SVPWillShow("载入中...")
        
        delog(UIImagePNGRepresentation(img1.currentImage!)!)
        delog(UIImagePNGRepresentation(img2.currentImage!)!)
        delog(UIImagePNGRepresentation(img3.currentImage!)!)

        Net.share.upLoadImageRequest(urlString: CBBCreateDiaryJoggle,
                                     params: up,
                                     data: [UIImagePNGRepresentation(img1.currentImage!)!,
                                            UIImagePNGRepresentation(img2.currentImage!)!,
                                            UIImagePNGRepresentation(img3.currentImage!)!],
                                     name: ["img1","img2","img3"],
                                     success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                SVPwillSuccessShowAndHide("创建日记本成功")
                self.navigationController?.popViewController(animated: true)
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("网络连接失败!")
        }
    }
    
    //  MARK: - 获取数据
    private func buildData() {
        
        var up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue]
            as [String: Any]
        
        if SelectOrderId.characters.count != 0 {
            up["id"] = SelectOrderId
        }
        
        delog(up)
        SVPWillShow("载入中...")
        
        Net.share.getRequest(urlString: CBBDiaryInfoJoggle, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            SVPHide()
            
            if json["code"].int == 1 {

                self.rebuildData(json)
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("网络连接失败!")
        }
    }
    
    private func rebuildData(_ json: JSON) {
        
        if SelectOrderId.characters.count == 0 {
            
            let data = json["data"]
            
            self.head.kf.setImage(with: StringToUTF_8InUrl(str: data["photo"].string!))
            self.name.text = data["nickName"].string!
            if data["gender"].string! == "1" {
                self.sex.image = UIImage(named:"nan_icon_default")
            }else {
                self.sex.image = UIImage(named:"nv_icon_default")
            }
        }else {
            
            let data = json["data"]
            
            //        //临时变过来的
            
//            private var completeDate = String()
//            private var productId = String()
//            private var orderId = String()
//            private var projectName = String()
//            private var projectId = String()
//            private var title = String()
//            private var ids = String()
            
            project.text = data["title"].string!
            product.text = data["projectName"].string!
            var doctorId = [String]()
            var doctorStr = String()
            for (_, subJson):(String, JSON) in data["doctors"] {
                doctorStr += subJson["doctorName"].string!
                doctorStr += "  "
                doctorId.append(subJson["id"].string!)
            }
            doctor.text = doctorStr
            
            completeDate = data["completeDate"].string!
            productId = data["productId"].string!
            orderId = data["orderId"].string!
            projectName = data["projectName"].string!
            projectId = data["projectId"].string!
            titles = data["title"].string!
            //反复进入订单列表二次选择容错
            ids = String()
            for index in doctorId {
                ids.append(index)
                if index != doctorId.last {
                    ids.append(",")
                }
            }
            delog(ids)
        }
    }
    
//    private func buildDay() {
//
//        let calendar: Calendar = Calendar(identifier: .gregorian)
//        var comps: DateComponents = DateComponents()
//        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
//        let dateStr = "\(comps.year!)-\(comps.month!)-\(comps.day!)"
//
//        date.text = "\(comps.month!)月\(comps.day!)日"
//
//        //字符串转
//        let formate = DateFormatter()
//        formate.dateFormat = "yyyy-MM-dd"
//        let strDate = formate.date(from: dateStr)
//        formate.dateFormat = "eee"
//        let weekStr = formate.string(from: strDate!)
//
//        week.text = weekStr
//    }
//
//    // MARK: - 时间选择逻辑
//    func selectDate() {
//        BRDatePickerView.showDatePicker(withTitle: "选择日期",
//                                        dateType: .date,
//                                        defaultSelValue: nil,
//                                        minDateStr: nil,
//                                        maxDateStr: nil,
//                                        isAutoSelect: false) { (time) in
//                                            delog(time)
//                                            self.getDateWithString(time!)
//        }
//    }
//
//    private func getDateWithString(_ dateStr: String!) {
//
//        var startIndex = dateStr.index(dateStr.startIndex, offsetBy: 5)
//        let endIndex = dateStr.index(startIndex, offsetBy: 2)
//        let tmp1 = dateStr.substring(with: startIndex..<endIndex)
//        delog(tmp1)
//
//        startIndex = dateStr.index(dateStr.startIndex, offsetBy: 8)
//        let tmp2 = dateStr.substring(from: startIndex)
//        delog(tmp2)
//
//        date.text = "\(tmp1)月\(tmp2)日"
//
//        //字符串转
//        let formate = DateFormatter()
//        formate.dateFormat = "yyyy-MM-dd"
//        let strDate = formate.date(from: dateStr)
//        formate.dateFormat = "eee"
//        let weekStr = formate.string(from: strDate!)
//
//        week.text = weekStr
//    }
    
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
        pick.view.frame = CGRect.init(x: 0, y: 64, width: WIDTH, height: HEIGHT-64)
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
        let btn = view.viewWithTag(currentTag) as! UIButton
        btn.setImage((info[UIImagePickerControllerEditedImage] as? UIImage)!, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.isSelected = true
    }
}
