//
//  item.swift
//  UItableView
//
//  Created by 崎原邦達 on 2021/04/10.
//


import UIKit

//プロパティ
class Item {
    var img:UIImage!
    var title:String!
    var subTitle:String!
    
    //コンストラクタ
    init(img:UIImage, title:String, subTitle:String) {
        self.img = img
        self.title = title
        self.subTitle = subTitle
    }
    
    func getImg() -> UIImage {
        return img
    }
    func getTitle() -> String {
        return title
    }
    func getSubTitle() -> String {
        return subTitle
    }
    
    
    
}



