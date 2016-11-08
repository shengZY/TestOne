//
//  ZYAnimationTextfield.swift
//  TestOneDemo
//
//  Created by xin on 16/8/10.
//  Copyright © 2016年 Phyllis. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}

//如果使用验证码样式，需要自己写点击事件，自己设置lable文字
/** normal普通，verCode验证码样式*/
enum ZYTextfieldViewType {
    /** 普通*/
    case normal
    /** 验证码*/
    case verCode
}
class ZYAnimationTextfield: UIView ,UITextFieldDelegate{
    
   fileprivate  enum ViewAnimationType {
        case up
        case down
    }
   fileprivate var animationtype :ViewAnimationType
   fileprivate lazy var backgoundView: UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.borderWidth = 1;
        backView.layer.borderColor = UIColor.zy_colorWithHex(hex: "0xcccccc").cgColor
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 6
        return backView
    }()
    
    lazy var textfield :UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = UIColor.zy_colorWithHex(hex: "0x4a4a4a")
        tf.rightViewMode = UITextFieldViewMode.whileEditing
        tf.delegate = self
        return tf
    }()
    lazy var descriptionLabel:UILabel = {
        let lable = UILabel()
        lable.textColor = UIColor.zy_colorWithHex(hex: "0xcccccc")
        lable.backgroundColor = UIColor.white
        lable.textAlignment = NSTextAlignment.center
        lable.font = UIFont.systemFont(ofSize: 16)
        return lable
    }()
    fileprivate lazy var verSeparateLine :UILabel = {
        let lineLbl = UILabel()
        lineLbl.backgroundColor = UIColor.zy_colorWithHex(hex: "0xcccccc")
        return lineLbl
    }()
    fileprivate lazy var deslableView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    fileprivate lazy var rightClearView:UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 54))
        let clearImage = UIImageView.init(image: UIImage.init(named: "clear"))
        clearImage.frame = CGRect(x: 25, y: 18, width: 18, height: 18)
        view.addSubview(clearImage)
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.frame = CGRect(x: 20, y: 0, width: 30, height: 54)
        btn.addTarget(self, action: #selector(ZYAnimationTextfield.clearBtnCliked(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)
        return view
    }()
    lazy var verTimeLbl:UILabel = {
       let lable = UILabel()
        lable.textAlignment = NSTextAlignment.center
        lable.font = UIFont.systemFont(ofSize: 14)
        return lable
    }()
    lazy var verButton:UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        return btn
    }()

    var textDelegate : UITextFieldDelegate?
    fileprivate var currentviewType : ZYTextfieldViewType
    init(frame: CGRect ,viewType:ZYTextfieldViewType,delegate:UITextFieldDelegate) {
        animationtype = ViewAnimationType.up
        currentviewType = viewType
        textDelegate = delegate
        super.init(frame: frame)
        self.textfield.rightView = rightClearView
        createSubvies()
        self.backgroundColor = UIColor.white
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func createSubvies() {
        self.addSubview(backgoundView)
        self.addSubview(deslableView)
        self.addSubview(textfield)
        deslableView.addSubview(descriptionLabel)
        
        backgoundView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(54)
        }
        deslableView.snp.makeConstraints { (make) in
            make.centerY.equalTo(backgoundView)
            make.left.equalTo(backgoundView.snp.left).offset(6)
            make.height.equalTo(20)
        }
        descriptionLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(deslableView)
            make.left.equalTo(deslableView.snp.left).offset(6)
            make.right.equalTo(deslableView.snp.right).offset(-6)
        }
        //手机号码
        if currentviewType == ZYTextfieldViewType.normal {
            textfield.snp.makeConstraints { (make) in
                make.centerY.equalTo(backgoundView.snp.centerY)
                make.height.equalTo(backgoundView.snp.height)
                make.left.equalTo(backgoundView.snp.left).offset(10)
                make.right.equalTo(backgoundView.snp.right)
            }
        }
        //验证码
        else{
            
            self.addSubview(verSeparateLine)
            self.addSubview(verTimeLbl)
            self.addSubview(verButton)
            textfield.snp.makeConstraints({ (make) in
                make.centerY.equalTo(backgoundView.snp.centerY)
                make.left.equalTo(backgoundView.snp.left).offset(10)
                make.right.equalTo(backgoundView.snp.centerX).offset(50)
                make.height.equalTo(backgoundView.snp.height)
            })
            verSeparateLine.snp.makeConstraints({ (make) in
                make.left.equalTo(textfield.snp.right).offset(4)
                make.width.equalTo(1)
                make.height.equalTo(30)
                make.bottom.equalTo(self.backgoundView.snp.bottom).offset(-12)
            })
            verTimeLbl.snp.makeConstraints({ (make) in
                make.left.equalTo(verSeparateLine.snp.right)
                make.right.equalTo(backgoundView.snp.right)
                make.height.equalTo(backgoundView.snp.height)
                make.centerY.equalTo(backgoundView.snp.centerY)
            })
            verButton.snp.makeConstraints({ (make) in
                make.left.equalTo(verSeparateLine.snp.right)
                make.right.equalTo(backgoundView.snp.right)
                make.height.centerY.equalTo(backgoundView)
            })
        }
    }
    func clearBtnCliked(_ button:UIButton) {
        self.textfield.text = "";
       self.textfield.resignFirstResponder()
//        [[NSNotificationCenter defaultCenter] postNotificationName:LoginInputViewClearNotifaction object:@"buttonUneable"];
//        [self.noticeView dismiss];
    }
    //MARK: - textfieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if animationtype == ViewAnimationType.up {
            UIView.animate(withDuration: 0.3, animations: {
                self.deslableView.transform = CGAffineTransform(translationX: -0.1 * self.deslableView.frame.size.width, y: -25).scaledBy(x: 0.8, y: 0.8)
                }, completion: { (finshed) in
                    self.animationtype = ViewAnimationType.down
            })
        }
        if let result = self.textDelegate?.textFieldShouldBeginEditing?(textField) {
            return result
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.characters.count <= 0 {
            if animationtype == ViewAnimationType.down {
                UIView.animate(withDuration: 0.3, animations: { 
                    self.deslableView.transform  = CGAffineTransform(translationX: 0, y: 0).scaledBy(x: 1.0, y: 1.0)
                    }, completion: { (finished) in
                        self.animationtype = ViewAnimationType.up
                })
            }
        }
        if let result = self.textDelegate?.textFieldShouldReturn?(textField){
            return result
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if let reuslt  = self.textDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string){
            return reuslt
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.characters.count <= 0 {
            if self.animationtype == ViewAnimationType.down {
                UIView.animate(withDuration: 0.3, animations: {
                    self.deslableView.transform = CGAffineTransform(translationX: 0, y: 0).scaledBy(x: 1.0, y: 1.0)
                    }, completion: { (finished) in
                        self.animationtype = ViewAnimationType.up
                })
            }
        }
         self.textDelegate?.textFieldDidEndEditing?(textField)
    }
    /** 设置边线颜色*/
    func borderColor(_ color:UIColor) {
        backgoundView.layer.borderColor = color.cgColor
        if currentviewType == ZYTextfieldViewType.verCode {
            verSeparateLine.backgroundColor = color
        }
    }
    
}
