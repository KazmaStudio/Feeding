//
//  ArticleTypeATableViewCell.swift
//  Feeding
//
//  Created by ZHAOCHENJUN on 2017/5/3.
//  Copyright © 2017年 com.kazmastudio. All rights reserved.
//

import UIKit

class ArticleTypeATableViewCell: UITableViewCell {

    @IBOutlet weak var articleListCellAuthorView: ArticleListCellAuthorView!
	@IBOutlet var imageViewFood: UIImageView!
	@IBOutlet var labelTitle: UILabel!
	@IBOutlet var labelArticleTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    
}
