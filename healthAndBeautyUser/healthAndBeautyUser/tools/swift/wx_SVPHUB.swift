//
//  wx_SVPHUB.swift
//  stateGridIMDemo
//
//  Created by helloworld on 2017/9/9.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SVProgressHUD

//可控制的
public func SVPWillControllerShow(_ str: String) {
    
    SVProgressHUD.setBackgroundColor(UIColor.white)
    SVProgressHUD.setForegroundColor(tabbarColor)
//    SVProgressHUD.setDefaultMaskType(.clear)
    SVProgressHUD.show(withStatus: "\(str)")
}

public func SVPwillControllerShowAndHide() {
    
    SVProgressHUD.setBackgroundColor(UIColor.white)
    SVProgressHUD.setForegroundColor(tabbarColor)
    //    SVProgressHUD.setDefaultMaskType(.clear)
    SVProgressHUD.setMinimumDismissTimeInterval(1.0)
    //    SVProgressHUD.showError(withStatus: str)
}


public func SVPWillShow(_ str: String) {
    
    SVProgressHUD.setBackgroundColor(UIColor.white)
    SVProgressHUD.setForegroundColor(tabbarColor)
//    SVProgressHUD.setDefaultMaskType(.clear)
    SVProgressHUD.show(withStatus: "\(str)")
}

public func SVPwillShowAndHide(_ str: String) {
    
    SVProgressHUD.setBackgroundColor(UIColor.white)
    SVProgressHUD.setForegroundColor(tabbarColor)
//    SVProgressHUD.setDefaultMaskType(.clear)
    SVProgressHUD.setMinimumDismissTimeInterval(1.0)
    SVProgressHUD.showError(withStatus: str)
}

public func SVPwillSuccessShowAndHide(_ str: String) {
    
    SVProgressHUD.setBackgroundColor(UIColor.white)
    SVProgressHUD.setForegroundColor(tabbarColor)
//    SVProgressHUD.setDefaultMaskType(.clear)
    SVProgressHUD.setMinimumDismissTimeInterval(1.0)
    SVProgressHUD.showSuccess(withStatus: str)
}



public func SVPHide() {
    
    SVProgressHUD.dismiss()
}

class wx_SVPHUB: NSObject {

}
