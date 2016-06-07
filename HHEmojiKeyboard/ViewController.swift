//
//  ViewController.swift
//  HHEmojiKeyboard
//
//  Created by xoxo on 16/6/6.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,HHEmojiKeyboardDelegate{
    var keyboard:HHEmojiKeyboard!
    var textView:UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dic = HHEmojiManage.getEmojiAll()
        var emojiArr:[String] = []
        for arr in dic.allValues {
            emojiArr = arr as! [String]
            break
        }
        let layout = HHCollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.sectionInset = UIEdgeInsetsZero
        let width:CGFloat = self.view.frame.size.width
        let frame = CGRectMake(0, self.view.frame.size.height - width*3/7, width, width*3/7)
        self.keyboard = HHEmojiKeyboard(frame: frame, collectionViewLayout: layout, stringArr: emojiArr, isShowDelete: true)
        self.keyboard.emojiKeyboardDelegate = self
        self.keyboard.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.keyboard)
        
        
        
//         /// 数字，数组
//        var dataArr:[[String]] = []
//        for _ in 0...5 {
//            var numArr:[String] = []
//            for i in 0...19 {
//                numArr.append(String(i))
//            }
//            dataArr.append(numArr)
//        }
//        
//        var matrixs:[[String]] = []
//        for numArr in dataArr {
//            matrixs.append(self.matrixTransformation(numArr, column: Int(HHEmojiKeyboard_Column)))
//        }
//        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .Horizontal
//        layout.sectionInset = UIEdgeInsetsZero
//        let width:CGFloat = self.view.frame.size.width
//        let frame = CGRectMake(0, self.view.frame.size.height - width*3/7, width, width*3/7)
//        self.keyboard = HHEmojiKeyboard(frame: frame, collectionViewLayout: layout, groupingArr: matrixs, isShowDelete: false)
//        self.keyboard.emojiKeyboardDelegate = self
//        self.keyboard.backgroundColor = UIColor.whiteColor()
//        self.view.addSubview(self.keyboard)
        
        
        
        let textFiledFrame = CGRectMake(0, CGRectGetMinY(self.keyboard.frame) - 30, width, 30)
        self.textView = UITextView(frame: textFiledFrame)
        self.textView.backgroundColor = UIColor.grayColor()
        self.view.addSubview(self.textView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - HHEmojiKeyboardDelegate
    func emojiKeyboard(emojiKeyboard:HHEmojiKeyboard,didSelectEmoji emoji:String){
        self.textView.text?.appendContentsOf(emoji)
    }
    
    func emojiKeyboardDidSelectDelete(emojiKeyboard:HHEmojiKeyboard){
        self.textView.deleteBackward()
    }
    
    func emojiKeyboard(emojiKeyboard: HHEmojiKeyboard, scrollDidTo pageIndex: Int) {
        print(pageIndex)
    }
    /**
     矩阵转换
     
     - parameter arr: 原来矩阵
     - parameter column: 列数
     - returns: 装置矩阵
     */
    func matrixTransformation(arr:[String],column:Int) -> [String] {
        var matrix:[String] = []
        var min = 1
        var preNum = -column
        for _ in 0..<arr.count {
            var num = preNum + column
            if num >= arr.count {
                num = min
                min += 1
            }
            matrix.append(arr[num])
            preNum = num
            
        }
        return matrix
    }
}

