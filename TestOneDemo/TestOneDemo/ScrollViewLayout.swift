//
//  ScrollViewLayout.swift
//  TestOneDemo
//
//  Created by xin on 16/7/21.
//  Copyright © 2016年 Phyllis. All rights reserved.
//

import UIKit
import SnapKit
let kSCreenWith = UIScreen.mainScreen().bounds.width
let kSCreenHeigth = UIScreen.mainScreen().bounds.height
@objc(ScrollViewLayout)
class ScrollViewLayout: UIViewController {
    var scorllview:UIScrollView!
    var container:UIView!
    var redView:UIView!
    var blueView:UIView!
    var button:UIButton!
    var status:Bool! = false
    override func viewDidLoad() {
        scorllview = UIScrollView()
        container = UIView()
        redView = UIView()
        blueView = UIView()
        button = UIButton.init(type: UIButtonType.System)
        button.setTitle("展开展开", forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(ScrollViewLayout.buttonClick), forControlEvents: UIControlEvents.TouchUpInside)
        button.titleLabel?.backgroundColor = UIColor.whiteColor()
        super.viewDidLoad()
        createSubViews()
        
    }
        func createSubViews(){
            redView.addSubview(button)
        redView.backgroundColor = UIColor.redColor()
        blueView.backgroundColor = UIColor.clearColor()
        scorllview.backgroundColor  = UIColor.grayColor()
        self.view.addSubview(scorllview)
//        scorllview.addSubview(container)
        scorllview.addSubview(redView)
        scorllview.addSubview(blueView)
        self.automaticallyAdjustsScrollViewInsets = false
        //scorllview 必须先确定位置大小
//            scorllview.clipsToBounds = false
        scorllview.snp_makeConstraints { (make) in
            make.center.equalTo(self.view.snp_center)
            make.size.equalTo(CGSizeMake(kSCreenWith - 40, kSCreenHeigth - 150))
        }
//        container.snp_makeConstraints { (make) in
//            make.left.right.top.bottom.equalTo(scorllview)
//        }
            
        redView.snp_makeConstraints { (make) in
            make.top.equalTo(scorllview.snp_top)//scorllview自动有个导航栏的高度，不关闭
            make.left.equalTo(scorllview.snp_left)
            make.width.equalTo(scorllview.snp_width)
            make.height.equalTo(100)
        }
            button.snp_makeConstraints { (make) in
                make.centerX.equalTo(redView.snp_centerX)
                make.width.equalTo(100)
                make.height.equalTo(40)
                make.bottom.equalTo(redView.snp_bottom).offset(-20)
            }
        blueView.snp_makeConstraints { (make) in
            make.top.equalTo(redView.snp_bottom).offset(20)
            make.left.equalTo(scorllview.snp_left)
//            make.right.equalTo(scorllview.snp_right)//这样写，blueview不会显示，因为没有宽度，因为scorllview.snp_right指的是scrollview的contentview的right，此时没有布局好，不知道content到底有多大，scrollview 约束太坑人
            make.width.equalTo(scorllview.snp_width)
            make.height.equalTo(600)//必须知道，因为需要计算content的size，同上
            make.bottom.equalTo(scorllview.snp_bottom).offset(-30)//bottom指的是contentview的bottom，会根据subview的大小自动计算
        }
        
     }
    func buttonClick() {
        print("buttonclick")
        if status == true {
            //open need close
            UIView.animateWithDuration(
                3, animations: { 
//                   self.redView.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, 0), 1.0, 1.0)
                    self.redView.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, 0), 1.0, 1.0)
            })
            
        }
        else{
            //close need open
            UIView.animateWithDuration(
                3, animations: {
//                    self.redView.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, 25), 0.5, 0.5)
                    self.redView.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, 0), 1.0, 300/self.redView.frame.size.height)
                    print("redView.frame.height \(self.redView.frame.size.height)")
            })
        }
        status = !status
        
        
    }
    
}
