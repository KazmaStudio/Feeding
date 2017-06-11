//
//  ArticleListModel.swift
//  Feeding
//
//  Created by zhaochenjun on 2017/5/8.
//  Copyright © 2017年 com.kazmastudio. All rights reserved.
//

import Foundation

class ArticleListModel: NSObject {
    var articleType: String = CELL_ARTICLE_LIST_TYPE_A
    var imageList: Array<String> = []
    var title: String = STRING_EMPTY
    var authorInfo: AuthorInfoModel = AuthorInfoModel()
    var targeted = false
    
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
