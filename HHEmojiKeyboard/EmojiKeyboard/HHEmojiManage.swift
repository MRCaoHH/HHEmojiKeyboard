//
//  HHEmojiManage.swift
//  HHEmojiKeyboard
//
//  Created by xoxo on 16/6/6.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import Foundation


class HHEmojiManage:NSObject {
    
    class func getEmojiAll() -> NSDictionary{
        if let path = NSBundle.mainBundle().pathForResource("EmojisList", ofType: "plist"){
            if let dic = NSDictionary(contentsOfFile: path as String){
                return dic
            }
        }
       return NSDictionary()
    }
    
}