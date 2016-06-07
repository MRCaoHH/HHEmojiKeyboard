//
//  HHEmojiKeyboard.swift
//  HHEmojiKeyboard
//
//  Created by xoxo on 16/6/6.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

let HHEmojiKeyboard_Column:CGFloat = 7

// MARK: - HHEmojiKeyboardDelegate 协议
protocol HHEmojiKeyboardDelegate:NSObjectProtocol {
    /**
     点击选择表情
     
     - parameter emojiKeyboard: emoji键盘
     - parameter emoji:         emoji表情
     */
    func emojiKeyboard(emojiKeyboard:HHEmojiKeyboard,didSelectEmoji emoji:String)
    
    /**
     点击删除按钮
     
     - parameter emojiKeyboard: emoji键盘
     */
    func emojiKeyboardDidSelectDelete(emojiKeyboard:HHEmojiKeyboard)
    
    /**
     翻页
     
     - parameter emojiKeyboard: emoji键盘
     - parameter pageIndex:     页面的下标从0开始
     */
    func emojiKeyboard(emojiKeyboard:HHEmojiKeyboard,scrollDidTo pageIndex:Int)
}

class HHEmojiKeyboard: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate {
     /// 数据源
    var dataArr:[[String]]!
     /// 是否显示删除按钮
    var delete:Bool = false
     /// 协议
    weak var emojiKeyboardDelegate:HHEmojiKeyboardDelegate?
     /// 每页emoji表情的总数,这里加上了删除按钮
    var pageEmojiCount:Int!{
        get{
            /// 行数
            let line = self.frame.size.height / (self.frame.width / HHEmojiKeyboard_Column)
            /// 一页的表情数
            let pageEmojiCount = Int(line) * Int(HHEmojiKeyboard_Column)
            return pageEmojiCount
        }
    }
    
    /**
     构造方法
     
     - parameter frame:  位置大小
     - parameter layout: 布局
     - parameter arr:    [String]数据,需要处理
     - parameter delete: 是否显示删除按钮
     
     - returns: HHEmojiKeyboard实例
     */
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout ,stringArr arr:[String]!,isShowDelete delete:Bool) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.registerClass(HHEmojiKeyboardCell.self, forCellWithReuseIdentifier: "HHEmojiKeyboardCell")
        self.registerClass(HHImageKeyboardCell.self, forCellWithReuseIdentifier: "HHImageKeyboardCell")
        self.pagingEnabled = true
        self.dataSource = self
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        self.delete = delete
        self.grouping(arr)
    }
    
    /**
     构造方法
     
     - parameter frame:  位置大小
     - parameter layout: 布局
     - parameter arr:    分组数据
     - parameter delete: 是否显示删除按钮
     
     - returns: HHEmojiKeyboard实例
     */
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout ,groupingArr arr:[[String]]!,isShowDelete delete:Bool){
        super.init(frame: frame, collectionViewLayout: layout)
        self.registerClass(HHEmojiKeyboardCell.self, forCellWithReuseIdentifier: "HHEmojiKeyboardCell")
        self.registerClass(HHImageKeyboardCell.self, forCellWithReuseIdentifier: "HHImageKeyboardCell")
        self.pagingEnabled = true
        self.dataSource = self
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        self.delete = delete
        self.dataArr = arr
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.pageEmojiCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        if indexPath.row == self.pageEmojiCount - 1 && self.delete{
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HHImageKeyboardCell", forIndexPath: indexPath) as!  HHImageKeyboardCell
            cell.imgView.image = UIImage(named: "aio_face_delete")
            return cell
        }else{
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HHEmojiKeyboardCell", forIndexPath: indexPath) as!  HHEmojiKeyboardCell
            if self.dataArr[indexPath.section].count > indexPath.row {
                cell.emojiLabel.text = self.dataArr[indexPath.section][indexPath.row]
            }else{
                cell.emojiLabel.text = ""
            }
            return cell
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return self.dataArr.count
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        if let delegate = self.emojiKeyboardDelegate {
            if let cell = collectionView.cellForItemAtIndexPath(indexPath){
                if cell.isKindOfClass(HHEmojiKeyboardCell){
                    if let content = (cell as! HHEmojiKeyboardCell).emojiLabel.text {
                        if content.characters.count > 0{
                            delegate.emojiKeyboard(self, didSelectEmoji: content)
                        }
                    }
                }else if cell.isKindOfClass(HHImageKeyboardCell){
                    delegate.emojiKeyboardDidSelectDelete(self)
                }
            }
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(self.frame.size.width / HHEmojiKeyboard_Column, self.frame.size.width / HHEmojiKeyboard_Column)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSizeZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        return CGSizeZero
    }

    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        if Int(scrollView.contentOffset.x)%Int(scrollView.frame.size.width) > 0 {
            page += 1
        }
        if let delegate = self.emojiKeyboardDelegate {
            delegate.emojiKeyboard(self, scrollDidTo: page)
        }
    }
    // MARK: - 分组
    func grouping(arr:[String]!){
        var pageEmojiCount = self.pageEmojiCount
        if self.delete {
            pageEmojiCount = pageEmojiCount - 1
        }
        
        var pageNumber:Int = arr.count / pageEmojiCount
        if arr.count%pageEmojiCount > 0 {
            pageNumber += 1
        }
        self.dataArr = []
        var emojis:[String] = []
        
        for i in 0..<pageNumber {
            emojis.removeAll()
            for j in 0..<pageEmojiCount {
                if i*pageEmojiCount + j >= arr.count {
                    break
                }
                emojis.append(arr[i*pageEmojiCount+j])
            }
            self.dataArr.append(emojis)
        }
    }
}
