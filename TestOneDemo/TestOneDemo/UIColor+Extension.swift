//
//  UIColor+Extension.swift
//  TestOneDemo
//
//  Created by xin on 16/8/10.
//  Copyright © 2016年 Phyllis. All rights reserved.
//

import UIKit

extension UIColor{

    /** hex 16进制串转Color*/
  class public func zy_colorWithHex(hex:String) -> UIColor {
        return proceesHex(hex, alpha: 1.0)
    }
    /** hex 16进制串转Color alpha 透明度*/
  class public func zy_colorWithHexAndAlpha(hex:String,alpha:CGFloat) -> UIColor {
        return proceesHex(hex, alpha: alpha)
    }
    
}
private func proceesHex(_ hex:String,alpha:CGFloat) -> UIColor{
    if hex.isEmpty{
        return UIColor.clear
    }
      var hHex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if hHex.characters.count < 6 {
        return UIColor.clear
    }
    
    if (hHex.hasPrefix("0x") || hHex.hasPrefix("0X")) {
        hHex = hHex.substring(from: hHex.characters.index(hHex.startIndex, offsetBy: 2))
    }
    if hHex.hasPrefix("#") {
        hHex = hHex.substring(from: hHex.characters.index(after: hHex.startIndex))
    }
    if hHex.hasPrefix("##") {
        hHex = hHex.substring(from: hHex.characters.index(hHex.startIndex, offsetBy: 2))
    }
    if hHex.characters.count != 6 {
        return UIColor.clear
    }
    
    /** R G B */
    var range = hHex.startIndex ..< hHex.characters.index(hHex.startIndex, offsetBy: 2)
    
    let rHex = hHex.substring(with: range)
    
    range = hHex.characters.index(hHex.startIndex, offsetBy: 2) ..< hHex.characters.index(hHex.startIndex, offsetBy: 4)
    let gHex = hHex.substring(with: range)
    
    range = hHex.characters.index(hHex.startIndex, offsetBy: 4) ..< hHex.endIndex
    let bHex = hHex.substring(with: range)
    
    var r:CUnsignedInt = 0,g:CUnsignedInt = 0, b:CUnsignedInt = 0
    
    Scanner(string: rHex).scanHexInt32(&r)
    Scanner(string: gHex).scanHexInt32(&g)
    Scanner(string: bHex).scanHexInt32(&b)
    
    return UIColor(red: CGFloat(r)/255.0,green:CGFloat(g)/255.0,blue: CGFloat(b)/255.0,alpha:alpha)
    
}
