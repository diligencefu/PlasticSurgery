//
//  NewMainADTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/24.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMainADTableViewCell: UITableViewCell {

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    
    var datas = [FYHSowMainADModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(moveToBigImage(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        let tapGes2 = UITapGestureRecognizer.init(target: self, action: #selector(moveToBigImage(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        let tapGes3 = UITapGestureRecognizer.init(target: self, action: #selector(moveToBigImage(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        
        image1.addGestureRecognizer(tapGes1)
        image2.addGestureRecognizer(tapGes2)
        image3.addGestureRecognizer(tapGes3)
        
        image1.contentMode = .scaleAspectFill
        image2.contentMode = .scaleAspectFill
        image3.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValuesForNewMainADTableViewCell(images:[FYHSowMainADModel]) {
        
        datas = images
        
        if datas.count == 3 {
            
            image1.kf.setImage(with: StringToUTF_8InUrl(str:images[0].infoBanner.imgUrl))
            image2.kf.setImage(with: StringToUTF_8InUrl(str:images[1].infoBanner.imgUrl))
            image3.kf.setImage(with: StringToUTF_8InUrl(str:images[2].infoBanner.imgUrl))
        }
    }
    
    
    @objc func moveToBigImage(tap:UITapGestureRecognizer) {
        
        var urlStr = ""
        var name = ""
        
        if datas.count < 3{
            return
        }
        
        switch tap.view?.tag {
        case 666?:
            urlStr = datas[0].infoBanner.linkUrl
            name = datas[0].infoBanner.name
            break
        case 667?:
            urlStr = datas[1].infoBanner.linkUrl
            name = datas[1].infoBanner.name
            break
        case 668?:
            urlStr = datas[2].infoBanner.linkUrl
            name = datas[2].infoBanner.name
            break
        default:
            break
        }
        
        let webView = FYHShowInfoWithWebViewController()
        webView.webTitle = name
        webView.webUrl = urlStr
        viewController()?.navigationController?.pushViewController(webView, animated: true)

//        if #available(iOS 10.0, *) {
//            UIApplication.shared.open(StringToUTF_8InUrl(str:urlStr), options: [:],
//                                      completionHandler: {
//                                        (success) in
//                                        if !success {
//                                            setToast(str: "网址格式错误！")
//                                        }
//            })
//        } else {
//            // Fallback on earlier versions
//        }
    }
}
