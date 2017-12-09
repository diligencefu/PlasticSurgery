//
//  debugModel.swift
//  hanFengSupermarket
//
//  Created by 吴玄 on 2017/4/17.
//  Copyright © 2017年 iOSMonkey. All rights reserved.
//

import Foundation

//自定义调试阶段log
public func delog(filePath: String = #file, rowCount: Int = #line) {
    #if DEBUG
        let fileName = (filePath as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        print(fileName + "      " + "/\(rowCount)行" + "\n")
    #endif
}

public func delog<T>(_ message: T, filePath: String = #file, rowCount: Int = #line) {
    #if DEBUG
        let fileName = (filePath as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        print(fileName + "      " + "/\(rowCount)行" + "      \(message)" + "\n")
    #endif
}
