//
//  ZYAnimationTextfield.swift
//  TestOneDemo
//
//  Created by xin on 16/8/10.
//  Copyright © 2016年 Phyllis. All rights reserved.
//

import UIKit
//如果使用验证码样式，需要自己写点击事件，自己设置lable文字
/** normal普通，verCode验证码样式*/
enum ZYTextfieldViewType {
    /** 普通*/
    case Normal
    /** 验证码*/
    case VerCode
}
class ZYAnimationTextfield: UIView ,UITextFieldDelegate{
    
   private  enum ViewAnimationType {
        case Up
        case Down
    }
   private var animationtype :ViewAnimationType
   private lazy var backgoundView: UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.whiteColor()
        backView.layer.borderWidth = 1;
        backView.layer.borderColor = UIColor.zy_colorWithHex(hex: "0xcccccc").CGColor
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 6
        return backView
    }()
    
    lazy var textfield :UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFontOfSize(16)
        tf.textColor = UIColor.zy_colorWithHex(hex: "0x4a4a4a")
        tf.rightViewMode = UITextFieldViewMode.WhileEditing
        tf.delegate = self
        return tf
    }()
    lazy var descriptionLabel:UILabel = {
        let lable = UILabel()
        lable.textColor = UIColor.zy_colorWithHex(hex: "0xcccccc")
        lable.backgroundColor = UIColor.whiteColor()
        lable.textAlignment = NSTextAlignment.Center
        lable.font = UIFont.systemFontOfSize(16)
        return lable
    }()
    private lazy var deslableView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    private lazy var rightClearView:UIView = {
        let view = UIView.init(frame: CGRectMake(0, 0, 50, 54))
        let clearImage = UIImageView.init(image: UIImage.init(named: "clear"))
        clearImage.frame = CGRectMake(25, 18, 18, 18)
        view.addSubview(clearImage)
        let btn = UIButton.init(type: UIButtonType.Custom)
        btn.frame = CGRectMake(20, 0, 30, 54)
        btn.addTarget(self, action: #selector(ZYAnimationTextfield.clearBtnCliked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btn)
        return view
    }()
    lazy var verTimeLbl:UILabel = {
       let lable = UILabel()
        lable.textAlignment = NSTextAlignment.Center
        lable.font = UIFont.systemFontOfSize(14)
        return lable
    }()
    lazy var verButton:UIButton = {
        let btn = UIButton.init(type: UIButtonType.Custom)
        return btn
    }()
    var textDelegate : UITextFieldDelegate?
    private var currentviewType : ZYTextfieldViewType
    init(frame: CGRect ,viewType:ZYTextfieldViewType,delegate:UITextFieldDelegate) {
        animationtype = ViewAnimationType.Up
        currentviewType = viewType
        textDelegate = delegate
        super.init(frame: frame)
        self.textfield.rightView = rightClearView
        createSubvies()
        self.backgroundColor = UIColor.whiteColor()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubvies() {
        self.addSubview(backgoundView)
        self.addSubview(deslableView)
        self.addSubview(textfield)
        deslableView.addSubview(descriptionLabel)
        
        backgoundView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.snp_centerX)
            make.bottom.equalTo(self.snp_bottom)
            make.width.equalTo(self.snp_width)
            make.height.equalTo(54)
        }
        deslableView.snp_makeConstraints { (make) in
            make.centerY.equalTo(backgoundView)
            make.left.equalTo(backgoundView.snp_left).offset(6)
            make.height.equalTo(20)
        }
        descriptionLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(deslableView)
            make.left.equalTo(deslableView.snp_left).offset(6)
            make.right.equalTo(deslableView.snp_right).offset(-6)
        }
        //手机号码
        if currentviewType == ZYTextfieldViewType.Normal {
            textfield.snp_makeConstraints { (make) in
                make.centerY.equalTo(backgoundView.snp_centerY)
                make.height.equalTo(backgoundView.snp_height)
                make.left.equalTo(backgoundView.snp_left).offset(10)
                make.right.equalTo(backgoundView.snp_right)
            }
        }
        //验证码
        else{
            let lineLbl = UILabel()
            lineLbl.backgroundColor = UIColor.zy_colorWithHex(hex: "0xcccccc")
            self.addSubview(lineLbl)
            self.addSubview(verTimeLbl)
            self.addSubview(verButton)
            textfield.snp_makeConstraints(closure: { (make) in
                make.centerY.equalTo(backgoundView.snp_centerY)
                make.left.equalTo(backgoundView.snp_left).offset(10)
                make.right.equalTo(backgoundView.snp_centerX).offset(50)
                make.height.equalTo(backgoundView.snp_height)
            })
            lineLbl.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(textfield.snp_right).offset(4)
                make.width.equalTo(1)
                make.height.equalTo(30)
                make.bottom.equalTo(self.backgoundView.snp_bottom).offset(-12)
            })
            verTimeLbl.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(lineLbl.snp_right)
                make.right.equalTo(backgoundView.snp_right)
                make.height.equalTo(backgoundView.snp_height)
                make.centerY.equalTo(backgoundView.snp_centerY)
            })
            verButton.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(lineLbl.snp_right)
                make.right.equalTo(backgoundView.snp_right)
                make.height.centerY.equalTo(backgoundView)
            })
        }
    }
    func clearBtnCliked(button:UIButton) {
        self.textfield.text = "";
       self.textfield.resignFirstResponder()
//        [[NSNotificationCenter defaultCenter] postNotificationName:LoginInputViewClearNotifaction object:@"buttonUneable"];
//        [self.noticeView dismiss];
    }
    //MARK: - textfieldDelegate
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if animationtype == ViewAnimationType.Up {
            UIView.animateWithDuration(0.3, animations: {
                self.deslableView.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(-0.1 * self.deslableView.frame.size.width, -25), 0.8, 0.8)
                }, completion: { (finshed) in
                    self.animationtype = ViewAnimationType.Down
            })
        }
        if let result = self.textDelegate?.textFieldShouldBeginEditing?(textField) {
            return result
        }
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text?.characters.count <= 0 {
            if animationtype == ViewAnimationType.Down {
                UIView.animateWithDuration(0.3, animations: { 
                    self.deslableView.transform  = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, 0), 1.0, 1.0)
                    }, completion: { (finished) in
                        self.animationtype = ViewAnimationType.Up
                })
            }
        }
        if let result = self.textDelegate?.textFieldShouldReturn?(textField){
            return result
        }
        return true
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

        if let reuslt  = self.textDelegate?.textField?(textField, shouldChangeCharactersInRange: range, replacementString: string){
            return reuslt
        }
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.text?.characters.count <= 0 {
            if self.animationtype == ViewAnimationType.Down {
                UIView.animateWithDuration(0.3, animations: {
                    self.deslableView.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, 0), 1.0, 1.0)
                    }, completion: { (finished) in
                        self.animationtype = ViewAnimationType.Up
                })
            }
        }
         self.textDelegate?.textFieldDidEndEditing?(textField)
    }
}