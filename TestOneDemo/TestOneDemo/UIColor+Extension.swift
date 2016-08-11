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
  class public func zy_colorWithHex(hex hex:String) -> UIColor {
        return proceesHex(hex, alpha: 1.0)
    }
    /** hex 16进制串转Color alpha 透明度*/
  class public func zy_colorWithHexAndAlpha(hex hex:String,alpha:CGFloat) -> UIColor {
        return proceesHex(hex, alpha: alpha)
    }
    
}
private func proceesHex(hex:String,alpha:CGFloat) -> UIColor{
    if hex.isEmpty{
        return UIColor.clearColor()
    }
    var hHex = (hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())).uppercaseString
    
    if hHex.characters.count < 6 {
        return UIColor.clearColor()
    }
    
    if (hHex.hasPrefix("0x") || hHex.hasPrefix("0X")) {
        hHex = hHex.substringFromIndex(hHex.startIndex.advancedBy(2))
    }
    if hHex.hasPrefix("#") {
        hHex = hHex.substringFromIndex(hHex.startIndex.successor())
    }
    if hHex.hasPrefix("##") {
        hHex = hHex.substringFromIndex(hHex.startIndex.advancedBy(2))
    }
    if hHex.characters.count != 6 {
        return UIColor.clearColor()
    }
    
    /** R G B */
    var range = hHex.startIndex ..< hHex.startIndex.advancedBy(2)
    
    let rHex = hHex.substringWithRange(range)
    
    range = hHex.startIndex.advancedBy(2) ..< hHex.startIndex.advancedBy(4)
    let gHex = hHex.substringWithRange(range)
    
    range = hHex.startIndex.advancedBy(4) ..< hHex.endIndex
    let bHex = hHex.substringWithRange(range)
    
    var r:CUnsignedInt = 0,g:CUnsignedInt = 0, b:CUnsignedInt = 0
    
    NSScanner(string: rHex).scanHexInt(&r)
    NSScanner(string: gHex).scanHexInt(&g)
    NSScanner(string: bHex).scanHexInt(&b)
    
    return UIColor(red: CGFloat(r)/255.0,green:CGFloat(g)/255.0,blue: CGFloat(b)/255.0,alpha:alpha)
    
}