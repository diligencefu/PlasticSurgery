//
//  NewFuJoggle.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/2.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

let fuNew = "http://192.168.1.114:8080/"

//  6.整形百科页面数据接口:
    /*
     http://192.168.1.104:8080/madical/m/rongxing/project/getProjects
     提交方式：get
     请求参数:
     id 项目分类编号（一级分类）第一次请求不传,后面点击分类操作必传
     
     projectList:
     name 二级项目分类名称（如果为空说明没有二级分类）
     projects:
     id 项目编号
     projectName 项目名称
     projrctClassifies
     id 项目分类编号(一级分类)
     name 项目分类名称(一级分类)
     */
let getproject_01_joggle = "\(fuNew)/madical/m/rongxing/project/getproject?id=1&SESSIONID=1&mobileCode=on"

class NewFuJoggle: NSObject {

}
