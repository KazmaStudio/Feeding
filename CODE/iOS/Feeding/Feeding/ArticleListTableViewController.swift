//
//  ArticleListTableViewController.swift
//  Feeding
//
//  Created by ZHAOCHENJUN on 2017/5/3.
//  Copyright © 2017年 com.kazmastudio. All rights reserved.
//

import UIKit

class ArticleListTableViewController: UITableViewController {
	
	let CELL_TYPE_A_HEIGHT = CGFloat(108)
    let CELL_TYPE_B_HEIGHT = CGFloat(256)
    var CELL_TYPE_C_HEIGHT = CGFloat(168)
    var articleList: Array<ArticleListModel> = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        fakeData()
        let cellTypeANib = UINib(nibName: CELL_ARTICLE_LIST_TYPE_A, bundle: nil)
        self.tableView.register(cellTypeANib, forCellReuseIdentifier: CELL_ARTICLE_LIST_TYPE_A)
        let cellTypeBNib = UINib(nibName: CELL_ARTICLE_LIST_TYPE_B, bundle: nil)
        self.tableView.register(cellTypeBNib, forCellReuseIdentifier: CELL_ARTICLE_LIST_TYPE_B)
        let cellTypeCNib = UINib(nibName: CELL_ARTICLE_LIST_TYPE_C, bundle: nil)
        self.tableView.register(cellTypeCNib, forCellReuseIdentifier: CELL_ARTICLE_LIST_TYPE_C)
        
        CELL_TYPE_C_HEIGHT = ((((SCREEN_WIDTH - 32) / 3) * 3) / 4) + 100
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articleList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch articleList[indexPath.row].articleType {
        case CELL_ARTICLE_LIST_TYPE_A:
            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ARTICLE_LIST_TYPE_A, for: indexPath) as! ArticleTypeATableViewCell
            cell.selectionStyle = .none
            cell.articleListCellAuthorView.imageViewAuthorAvater.image = UIImage.init(named: IMG_NAME_AVATAR_DEFAULT_GIRL)
            cell.articleListCellAuthorView.imageViewTag.image = UIImage.init(named: articleList[indexPath.row].authorInfo.authorAvatar)
            cell.articleListCellAuthorView.labelAuthorName.text = articleList[indexPath.row].authorInfo.authorName
            cell.imageViewFood.image = UIImage.init(named: articleList[indexPath.row].imageList[0])
            cell.labelTitle.text = articleList[indexPath.row].title
            return cell
        case CELL_ARTICLE_LIST_TYPE_B:
            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ARTICLE_LIST_TYPE_B, for: indexPath) as! ArticleTypeBTableViewCell
            cell.selectionStyle = .none
            cell.articleListCellAuthorView.imageViewAuthorAvater.image = UIImage.init(named: IMG_NAME_AVATAR_DEFAULT_GIRL)
            cell.articleListCellAuthorView.imageViewTag.image = UIImage.init(named: articleList[indexPath.row].authorInfo.authorAvatar)
            cell.articleListCellAuthorView.labelAuthorName.text = articleList[indexPath.row].authorInfo.authorName
            cell.imageViewFood.image = UIImage.init(named: articleList[indexPath.row].imageList[0])
            cell.labelTitle.text = articleList[indexPath.row].title
            return cell
        case CELL_ARTICLE_LIST_TYPE_C:
            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ARTICLE_LIST_TYPE_C, for: indexPath) as! ArticleTypeCTableViewCell
            cell.selectionStyle = .none
            cell.articleListCellAuthorView.imageViewAuthorAvater.image = UIImage.init(named: IMG_NAME_AVATAR_DEFAULT_GIRL)
            cell.articleListCellAuthorView.imageViewTag.image = UIImage.init(named: articleList[indexPath.row].authorInfo.authorAvatar)
            cell.articleListCellAuthorView.labelAuthorName.text = articleList[indexPath.row].authorInfo.authorName
            cell.imageViewFoodLeft.image = UIImage.init(named: articleList[indexPath.row].imageList[0])
            cell.imageViewFoodCenter.image = UIImage.init(named: articleList[indexPath.row].imageList[1])
            cell.imageViewFoodRight.image = UIImage.init(named: articleList[indexPath.row].imageList[2])
            cell.labelTitle.text = articleList[indexPath.row].title
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ARTICLE_LIST_TYPE_A, for: indexPath) as! ArticleTypeATableViewCell
            cell.selectionStyle = .none
            cell.articleListCellAuthorView.imageViewAuthorAvater.image = UIImage.init(named: IMG_NAME_AVATAR_DEFAULT_GIRL)
            cell.articleListCellAuthorView.imageViewTag.image = UIImage.init(named: articleList[indexPath.row].authorInfo.authorAvatar)
            cell.articleListCellAuthorView.labelAuthorName.text = articleList[indexPath.row].authorInfo.authorName
            cell.imageViewFood.image = UIImage.init(named: articleList[indexPath.row].imageList[0])
            cell.labelTitle.text = articleList[indexPath.row].title
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch articleList[indexPath.row].articleType {
        case CELL_ARTICLE_LIST_TYPE_A:
            return CELL_TYPE_A_HEIGHT
        case CELL_ARTICLE_LIST_TYPE_B:
            return CELL_TYPE_B_HEIGHT
        case CELL_ARTICLE_LIST_TYPE_C:
            return CELL_TYPE_C_HEIGHT
        default:
            return CELL_TYPE_A_HEIGHT
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: VC_NAME_ARTICLE, bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: VC_NAME_ARTICLE)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
	
	override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
		let cell = tableView.cellForRow(at: indexPath)
		CELL_HIGHLIGHT(cell: cell!)
		return true
	}
	
	override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath)
		CELL_UNHIGHLIGHT(cell: cell!)
	}
    
    func fakeData(){
        let article1: ArticleListModel = ArticleListModel()
        article1.title = "New Title Here, It's a Long Title, Wrap Please. Wrap Wrap Wrap. More Lines, Maybe three Line. Other Line, Good Title"
        article1.imageList = [IMG_NAME_PLACEHOLDER, IMG_NAME_PLACEHOLDER, IMG_NAME_PLACEHOLDER]
        article1.authorInfo.authorName = "NewAuthor"
        article1.articleType = CELL_ARTICLE_LIST_TYPE_C
        articleList.append(article1)

        let article5: ArticleListModel = ArticleListModel()
        article5.title = "New Title Here"
        article5.imageList = [IMG_NAME_PLACEHOLDER, IMG_NAME_PLACEHOLDER, IMG_NAME_PLACEHOLDER]
        article5.authorInfo.authorName = "NewAuthor"
        article5.articleType = CELL_ARTICLE_LIST_TYPE_C
        articleList.append(article5)
        
        let article2: ArticleListModel = ArticleListModel()
        article2.title = "New Title Here"
        article2.imageList = [IMG_NAME_PLACEHOLDER]
        article2.authorInfo.authorAvatar = IMG_NAME_RECORD
        article2.authorInfo.authorName = "NewAuthor"
        article2.articleType = CELL_ARTICLE_LIST_TYPE_A
        articleList.append(article2)
        
        let article4: ArticleListModel = ArticleListModel()
        article4.title = "New Title Here"
        article4.imageList = [IMG_NAME_PLACEHOLDER]
        article4.authorInfo.authorName = "NewAuthor"
        article4.articleType = CELL_ARTICLE_LIST_TYPE_B
        articleList.append(article4)
        
        let article3: ArticleListModel = ArticleListModel()
        article3.title = "New Title Here, It's a Long Title, Wrap Please. Wrap Wrap Wrap. More Lines, Maybe three Line. Other Line, Good Title"
        article3.imageList = [IMG_NAME_PLACEHOLDER]
        article3.authorInfo.authorName = "NewAuthor"
        article3.articleType = CELL_ARTICLE_LIST_TYPE_A
        articleList.append(article3)

    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
