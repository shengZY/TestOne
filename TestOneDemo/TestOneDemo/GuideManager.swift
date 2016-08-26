//
//  GuideManager.swift
//  TestOneDemo
//
//  Created by xin on 16/8/12.
//  Copyright © 2016年 Phyllis. All rights reserved.
//

import UIKit

enum GuideType : Int
{
    case Guide_ImageView_OrderCenter = 100      // 订单中心引导页面 1
    case Guide_ImageView_OrderCenter_Next       // 订单中心引导页面 2
    case Guide_ImageView_OrderCenter_Next_Next  // 订单中心引导页面 3
    case Guide_ImageView_UserCenter_First       // 用户中心引导页面 1
    case Guide_ImageView_UserCenter_Second      // 用户中心引导页面 2
    case Guide_ImageView_UserCenter_Third       // 用户中心引导页面 3
    case Guide_ImageView_UserCenter_Four        // 用户中心引导页面 4
    case GuideWelcomeView                       // 增加程序启动引导页
    case APP_First_Start                        // 程序第一次启动
    case Guide_ImageView_ProductCenter          // 产品列表
    case Guide_ImageView_ProductCenter_Detail   // 产品详情
};

class GuideManager: NSObject {
    var _guideDict : [String: NSNumber]?
    let GuideManagerConfig = "GuideManagerConfig"
    var tmpView:UIView?

    static let sharedInstance = GuideManager()
    private override init(){
        _guideDict = StandardUserDefaults.objectForKey(GuideManagerConfig) as? [String:NSNumber]
        if let _ = _guideDict {
            
        }else{
            _guideDict = [String: NSNumber]()
            StandardUserDefaults.setObject(_guideDict, forKey: GuideManagerConfig);
            StandardUserDefaults.synchronize()
        }
    }
    func hasShownGuide(guideType:GuideType) -> Bool {
        return _guideDict!.getNoNullNumberWithKey(StringInt(guideType.rawValue)).boolValue
    }
}
