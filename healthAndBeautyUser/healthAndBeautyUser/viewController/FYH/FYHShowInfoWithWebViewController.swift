//
//  FYHShowInfoWithWebViewController.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import WebKit
import WebViewJavascriptBridge

class FYHShowInfoWithWebViewController: Base2ViewController,UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate,UIGestureRecognizerDelegate {

    var webUrl = ""
    var webTitle = ""
    var goodId = ""
    
    var bridge = WebViewJavascriptBridge()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVPWillShow("载入中...")
        setupTitleViewSectionStyle(titleStr: webTitle)

//        var webView = WKWebView.init(frame: CGRect(x: 0, y: CGFloat(navHeight), width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - CGFloat(navHeight)))
//        let webConfiguration = WKWebViewConfiguration()
//        let webView = WKWebView(frame: CGRect(x: 0, y: CGFloat(navHeight), width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - CGFloat(navHeight)), configuration: webConfiguration)
//
//        if webUrl.contains("http") {
//            let myRequest = URLRequest(url: OCTools.getEfficientAddress(webUrl))
//            webView.load(myRequest)
//        }else{
//            let myRequest = URLRequest(url: OCTools.getEfficientAddress("http://"+webUrl))
//            webView.load(myRequest)
//        }
//
//        if goodId.count>0 {
//            webView.evaluateJavaScript(backInfo()) { (response, error) in
//                print(response)
//           }
//            webView.evaluateJavaScript("document.title", completionHandler: { (response, error) in
//                print(response)
//            })
//
//        }
//
//
//        view.addSubview(webView)
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self

        // Do any additional setup after loading the view.
        let web = UIWebView.init(frame: CGRect(x: 0, y: CGFloat(navHeight), width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - CGFloat(navHeight)))
        view.addSubview(web)
        
       
        if webUrl.contains("http") {
            web.loadRequest(URLRequest.init(url: OCTools.getEfficientAddress(webUrl)))
        }else{
            web.loadRequest(URLRequest.init(url: OCTools.getEfficientAddress("http://"+webUrl)))
        }
        WebViewJavascriptBridge.enableLogging()
        
        bridge = WebViewJavascriptBridge.init(web)
//        bridge = WebViewJavascriptBridge(web)
        bridge.setWebViewDelegate(self)
        
        bridge.registerHandler(backInfo()) { (data, responseCallback) in
            let sub = data as! [String: Int]
            delog(sub["id"]!)
            
//            let vc = GoodsDetailViewController()
//            vc.goodsId = UInt64(sub["id"]!)
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func backInfo() -> (String) {
        return Defaults["SESSIONID"].stringValue+","+Defaults["mobileCode"].stringValue+","+goodId
    }
    
    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        let inputValues = "document.getElementsByName('input')[0].attributes['value'].value"
//        webView.evaluateJavaScript(inputValues) { (response, error) in
//            print(response!,error!)
//        }
//
//    }
//
//
//    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
//
//    }

    override func viewWillDisappear(_ animated: Bool) {
        SVPHide()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
