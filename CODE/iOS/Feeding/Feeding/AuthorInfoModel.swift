//
//  AuthorInfoModel.swift
//  Feeding
//
//  Created by zhaochenjun on 2017/5/8.
//  Copyright © 2017年 com.kazmastudio. All rights reserved.
//

import Foundation

class AuthorInfoModel: NSObject {
    var authorName: String = EMPTY_STRING
    var authorAvatar: String = EMPTY_STRING
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override init() {
        super.init()
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.setValuesForKeys(dict)
    }
}
