//
//  TwoViewController.swift
//  TestOneDemo
//
//  Created by Yuu_zhang on 16/3/10.
//  Copyright © 2016年 Phyllis. All rights reserved.
//

import UIKit



@objc(TwoViewController)

class TwoViewController: UIViewController ,UITextFieldDelegate {
    var textfield : ZYAnimationTextfield! /** textfield */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red;
        // Do any additional setup after loading the view.
        let possibleNumber = "123"
        let convertedNumber = Int(possibleNumber)
        if convertedNumber != nil {
            print("convertedNumber contains some interger value")
        }
        
//        let age = -3
//        assert(age>=0 , "a person's age cannot be less than zero")
        var a  = 1
        a += 2
        print(a)
        

        let array = ["2","3","5","7","9","11","5","7","3","2"]
        let orderArray =  array.sorted { (first, second) -> Bool in
            first < second
        }
        print(orderArray)
        let set  = Set(orderArray)
        print(set)
        
        
        var lastArray :Array<AnyObject> = []
        for item in set {
            var originalArray :Array<String> = []
            for original in orderArray {
                if original == item {
                    originalArray.append(item)
                }
            }
            
            lastArray.append(originalArray as AnyObject)
        }
        print(lastArray)
        textfield =  ZYAnimationTextfield.init(frame: CGRect(x: 40, y: 100, width: kSCreenWith - 80, height: 84) ,viewType: ZYTextfieldViewType.verCode,delegate: self)
        textfield.descriptionLabel.text = "请输入用户名"
        textfield.verTimeLbl.text = "获取验证码"
        textfield.borderColor(UIColor.red)
        textfield.verButton.addTarget(self, action: #selector(TwoViewController.verCodeButtonClicked(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(textfield)
    }
    func verCodeButtonClicked(_ button:UIButton) {
        print("get vercode")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getPriousorLaterDateFormDate(_ date:Date , day : Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = day
        let calender = Calendar.init(identifier: Calendar.Identifier.gregorian)
        let mdate =  (calender as NSCalendar?)?.date(byAdding: dateComponents, to: date, options: NSCalendar.Options.wrapComponents)
        return mdate!
    }
    
    func makeXValues() -> [String] {
        var dateArr = [ String ]()
        let currentDate = Date()
        let labelFormatter = DateFormatter()
        labelFormatter.dateFormat = "MMM-dd"
        for i  in -4..<2 {
            let date  = getPriousorLaterDateFormDate(currentDate, day: i)
            let dateStr = labelFormatter.string(from: date)
            dateArr.append(dateStr)
        }
        return dateArr
    }
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        if range.location > 5 {
//            return false
//        }
//        return true
//    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textfield.textfield.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
