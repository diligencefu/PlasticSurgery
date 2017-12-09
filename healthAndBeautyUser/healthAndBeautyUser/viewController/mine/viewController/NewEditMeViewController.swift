//
//  NewEditMeViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/4.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewEditMeViewController: Wx_baseViewController,
                                UIImagePickerControllerDelegate,
                                UINavigationControllerDelegate  {
    
    var id = String()
    var meModel = NewEditMeModel()
    var isLoad : Bool = false

    var head = UIImageView()
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(UINib.init(nibName: "NewMeDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "NewMeDetailTableViewCell")
        table.register(UINib.init(nibName: "NewMeHeadTableViewCell", bundle: nil), forCellReuseIdentifier: "NewMeHeadTableViewCell")
        
        table.register(NewEditSelectTabTabCell.self, forCellReuseIdentifier: "NewEditSelectTabTabCell")
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "编辑资料", leftBtn: buildLeftBtn(), rightBtn: buildRightBtnWithName("完成"))
        buildData()
        buildUI()
    }
    override func rightClick() {
        
        self.view.endEditing(true)
        var ids = String()
        for index in EditSelectArr {
            ids += index
            if index != EditSelectArr.last {
                ids += ","
            }
        }
        
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "nickName":NewMeDetailTableViewCellName,
                  "gender":NewMeDetailTableViewCellSex,
                  "birthday":NewMeDetailTableViewCellBirthday,
                  "area":NewMeDetailTableViewCellArea,
                  "ids":ids]
        
        delog(up)
        SVPWillShow("加载中...")
        
        let head = view.viewWithTag(9988) as! NewMeHeadTableViewCell
        
        Net.share.reBuildHeadUpLoadImageRequest(urlString: updateUserInfo_38_joggle,
                                                params: up,
                                                data: [head.hrad.image!],
                                                name: ["head"],
                                                success: { (datas) in
                                                    let json = JSON(datas)
                                                    SVPHide()
                                                    delog(json)
                                                    if json["code"].int == 1 {
                                                        SVPwillSuccessShowAndHide("上传数据成功")
                                                        self.navigationController?.popViewController(animated: true)
                                                    }else {
                                                        SVPwillShowAndHide(json["message"].string!)
                                                    }
        }) { (error) in
            delog(error)
        }
    }
    
    private func buildUI() {
        
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(naviView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
    }
    
    private func buildData() {
        
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue]
            as [String: Any]
        
        delog(up)
        SVPWillShow("加载中...")
        
        Net.share.getRequest(urlString: getUserInfo_37_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            SVPHide()
            delog(json)
            if json["code"].int == 1 {
                
                self.meModel.id = json["data"]["personal"]["id"].string!
                self.meModel.nickName = json["data"]["personal"]["nickName"].string!
                self.meModel.photo = json["data"]["personal"]["photo"].string!
                self.meModel.gender = json["data"]["personal"]["gender"].string!
                self.meModel.age = json["data"]["personal"]["age"].int!
                self.meModel.birthday = json["data"]["personal"]["birthday"].string!
                self.meModel.area = json["data"]["personal"]["area"].string!
                self.meModel.integral = json["data"]["personal"]["integral"].int!
                self.meModel.isDoProject = json["data"]["isDoProject"].int!
                for (_, subJson):(String, JSON) in json["data"]["personal"]["projectClassifys"] {
                    //做过的项目
                    let model = projectClassifys()
                    model.id = subJson["id"].string!
                    model.name = subJson["name"].string!
                    self.meModel.projectClassified.append(model)
                }
                for (_, subJson):(String, JSON) in json["data"]["projectClassifys"] {
                    //全部项目
                    let model = projectClassifys()
                    model.id = subJson["id"].string!
                    model.name = subJson["name"].string!
                    self.meModel.projectClassify.append(model)
                }
                self.isLoad = true
                self.tableView.reloadData()
            }
        }) { (error) in
            delog(error)
        }
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
        
        let head = view.viewWithTag(9988) as! NewMeHeadTableViewCell
        head.hrad.image = info[UIImagePickerControllerEditedImage]! as? UIImage
    }
}

// MARK: - UITableViewDelegate
extension NewEditMeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            showImage()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 66
        }else if indexPath.section == 1 {
            return 179
        }else if indexPath.section == 2 {
            return GET_SIZE * 300
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:NewMeHeadTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMeHeadTableViewCell") as? NewMeHeadTableViewCell
            cell?.tag = 9988
            cell?.selectionStyle = .none
            cell?.model = meModel
            head = cell!.hrad
            return cell!
        }else if indexPath.section == 1 {
            let cell:NewMeDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMeDetailTableViewCell") as? NewMeDetailTableViewCell
            cell?.selectionStyle = .none
            cell?.model = meModel
            return cell!
        }else if indexPath.section == 2 {
            var cell:NewEditSelectTabTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewEditSelectTabTabCell") as? NewEditSelectTabTabCell
            if nil == cell {
                cell! = NewEditSelectTabTabCell.init(style: .default, reuseIdentifier: "NewEditSelectTabTabCell")
            }
            cell?.selectionStyle = .none
            cell?.editModel = meModel
            return cell!
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let tmp = UIView()
        tmp.backgroundColor = lineColor
        return tmp
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0
        }
        return 10
    }
}

// MARK: - UITableViewDataSource
extension NewEditMeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isLoad {
            return 0
        }
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
