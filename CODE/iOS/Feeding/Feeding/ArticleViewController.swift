//
//  ArticleViewController.swift
//  Feeding
//
//  Created by zhaochenjun on 2017/5/8.
//  Copyright © 2017年 com.kazmastudio. All rights reserved.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController, UIScrollViewDelegate, WKNavigationDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Outlet
    @IBOutlet weak var tableViewComment: UITableView!
    @IBOutlet weak var layoutConstraintViewTitleTop: NSLayoutConstraint!
    @IBOutlet weak var avTargetOperate: UIActivityIndicatorView!
    @IBOutlet weak var progressWebView: UIProgressView!
    @IBOutlet weak var layoutConstraintViewWebTop: NSLayoutConstraint!
    @IBOutlet weak var layoutConstraintLabelAuthorTop: NSLayoutConstraint!
    @IBOutlet weak var viewAuthor: UIView!
    @IBOutlet weak var viewWebViewBase: UIView!
    @IBOutlet weak var layoutConstraintVisualViewBottomHeight: NSLayoutConstraint!
    @IBOutlet weak var viewButtonBar: UIVisualEffectView!
    @IBOutlet weak var viewTopHeight: NSLayoutConstraint!
    @IBOutlet weak var visualEffectViewTop: UIVisualEffectView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var layoutConstraintVisualEffectViewBottomBottom: NSLayoutConstraint!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewCover: UIView!
    
    // MARK: Parameter
    var webViewMain: WKWebView!
    var WEB_VIEW_SCROLL_VIEW_OFFSET_Y = CGFloat(INT_0)
    var VISUAL_EFFECT_VIEW_TOP_HEIGHT = CGFloat(INT_0)
    var boolTargetAdded = false
    var commentShowed = false
    let VIEW_TOP_MIN_HEIGHT = STATEBAR_HEIGHT
    let LABEL_TITLE_MAX_FONT_SIZE = CGFloat(INT_14)
    let LABEL_TITLE_MIN_FONT_SIZE = CGFloat(INT_12)
    let AUTHOR_TOP = CGFloat(INT_96)
    let AUTHOR_TOP_DELTA = CGFloat(INT_40)
    
    var CELL_TYPE_C_HEIGHT = CGFloat(0)
    var commentList: Array<ArticleListModel> = []
    
    // MARK: UIView delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isStatusBarHidden = true
        webViewMain = WKWebView.init()
        webViewMain.alpha = CGFloat(INT_0)
        webViewMain.scrollView.backgroundColor = UIColor.clear
        webViewMain.addObserver(self, forKeyPath: OBSERVE_KEY_ESTIMATED_PROGRESS, options: .new, context: nil)
        
        tableViewComment.delegate = self
        tableViewComment.dataSource = self
        let cellTypeANib = UINib(nibName: CELL_ARTICLE_LIST_TYPE_C, bundle: nil)
        tableViewComment.register(cellTypeANib, forCellReuseIdentifier: CELL_ARTICLE_LIST_TYPE_C)
        fakeData()
        
        tableViewComment.register(UINib(nibName: "AddCommentHeader", bundle:nil),
                           forCellReuseIdentifier: "header")
        tableViewComment.contentInset = UIEdgeInsets.init(top: CGFloat(INT_0), left: CGFloat(INT_0), bottom: layoutConstraintVisualViewBottomHeight.constant, right: CGFloat(INT_0))
        CELL_TYPE_C_HEIGHT = ((((SCREEN_WIDTH - 32) / 3) * 3) / 4) + 100
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        labelTitle.text = "这是个新标题，一个中文标题。这而且是个很长很长的标题，换行，换行，继续换行。超长的标题，又要换行了"
        webViewMain.load(URLRequest.init(url: URL.init(string: "https://open.hulubank.com.cn")!))
        webViewMain.scrollView.delegate = self
        webViewMain.navigationDelegate = self
        WEB_VIEW_SCROLL_VIEW_OFFSET_Y = -viewTopHeight.constant
        VISUAL_EFFECT_VIEW_TOP_HEIGHT = viewTopHeight.constant
        webViewMain.scrollView.contentInset = UIEdgeInsets.init(top: CGFloat(INT_64), left: CGFloat(INT_0), bottom: layoutConstraintVisualViewBottomHeight.constant, right: CGFloat(INT_0))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        UIApplication.shared.isStatusBarHidden = false
        webViewMain.removeObserver(self, forKeyPath: OBSERVE_KEY_ESTIMATED_PROGRESS, context: nil)
    }
    
    override func viewDidLayoutSubviews() {
        
        webViewMain.frame = viewWebViewBase.bounds
        viewWebViewBase.addSubview(webViewMain)
        if ((self.tabBarController) != nil){
            if(self.tabBarController?.tabBar.isHidden)!{
                layoutConstraintVisualEffectViewBottomBottom.constant = CGFloat(INT_0)
            }else{
                layoutConstraintVisualEffectViewBottomBottom.constant = -TAB_BAR_HEIGHT
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == OBSERVE_KEY_ESTIMATED_PROGRESS){
            progressWebView.setProgress(Float(webViewMain.estimatedProgress), animated: true)
            if (webViewMain.estimatedProgress >= 1.0){
                UIView.animate(withDuration: 1, animations: {
                    self.progressWebView.alpha = CGFloat(INT_0)
                }, completion: {finished in
                    self.progressWebView.setProgress(Float(INT_0), animated: false)
                })
            }
        }
    }
    
    // MARK: WKWebview delegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        viewCover.isHidden = false
        UIView.animate(withDuration: 1, animations: {
            webView.alpha = CGFloat(INT_1)
        }, completion: {finished in
            
        })
        
    }
    
    // MARK: Scroll View delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.superview == webViewMain){
            let targetViewTopHeight = VISUAL_EFFECT_VIEW_TOP_HEIGHT - scrollView.contentOffset.y - 64
            if(targetViewTopHeight < VIEW_TOP_MIN_HEIGHT){
                viewTopHeight.constant = VIEW_TOP_MIN_HEIGHT
                labelTitle.font = UIFont.boldSystemFont(ofSize: LABEL_TITLE_MIN_FONT_SIZE)
                layoutConstraintLabelAuthorTop.constant = AUTHOR_TOP
            }else{
                viewTopHeight.constant = targetViewTopHeight
                let targetLabelTitleFontSize = (LABEL_TITLE_MAX_FONT_SIZE - (VISUAL_EFFECT_VIEW_TOP_HEIGHT - viewTopHeight.constant))
                if (targetLabelTitleFontSize <= LABEL_TITLE_MIN_FONT_SIZE){
                    labelTitle.font = UIFont.boldSystemFont(ofSize: LABEL_TITLE_MIN_FONT_SIZE)
                }else if (targetLabelTitleFontSize > LABEL_TITLE_MAX_FONT_SIZE){
                    labelTitle.font = UIFont.boldSystemFont(ofSize: LABEL_TITLE_MAX_FONT_SIZE)
                }else{
                    labelTitle.font = UIFont.boldSystemFont(ofSize: targetLabelTitleFontSize)
                }
                if (targetViewTopHeight > (AUTHOR_TOP_DELTA + AUTHOR_TOP)){
                    layoutConstraintLabelAuthorTop.constant = targetViewTopHeight - AUTHOR_TOP_DELTA
                }else{
                    layoutConstraintLabelAuthorTop.constant = AUTHOR_TOP
                }
            }
            self.webViewMain.scrollView.scrollIndicatorInsets = UIEdgeInsets.init(top: viewTopHeight.constant, left: CGFloat(INT_0), bottom: layoutConstraintVisualViewBottomHeight.constant, right: CGFloat(INT_0))
        }
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return INT_1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ARTICLE_LIST_TYPE_C, for: indexPath) as! ArticleTypeCTableViewCell
        cell.selectionStyle = .none
        cell.articleListCellAuthorView.imageViewAuthorAvater.image = UIImage.init(named: IMG_NAME_AVATAR_DEFAULT_GIRL)
        cell.articleListCellAuthorView.imageViewTag.image = UIImage.init(named: commentList[indexPath.row].targeted ? IMG_NAME_TARGET_COLOR : STRING_EMPTY)
        cell.articleListCellAuthorView.labelAuthorName.text = commentList[indexPath.row].authorInfo.authorName
        cell.imageViewFoodLeft.image = UIImage.init(named: commentList[indexPath.row].imageList[0])
        cell.imageViewFoodCenter.image = UIImage.init(named: commentList[indexPath.row].imageList[1])
        cell.imageViewFoodRight.image = UIImage.init(named: commentList[indexPath.row].imageList[2])
        cell.labelTitle.text = commentList[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_TYPE_C_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let cell = tableView.cellForRow(at: indexPath)
        CELL_HIGHLIGHT(cell: cell!)
        return true
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        CELL_UNHIGHLIGHT(cell: cell!)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableCell(withIdentifier: "header")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    // MARK: IBAction
    @IBAction func buttonBackTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonCommentTap(_ sender: UIButton) {
        if (commentShowed){
            commentShowed = false
            sender.setImage(UIImage.init(named: IMG_NAME_CHAT), for: .normal)
            layoutConstraintViewWebTop.constant = CGFloat(INT_0)
            layoutConstraintViewTitleTop.constant = CGFloat(INT_0)
            UIView.animate(withDuration: 0.4, delay: TimeInterval(INT_0), options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: {finished in
            })
        }else{
            commentShowed = true
            sender.setImage(UIImage.init(named: IMG_NAME_ARTICLE), for: .normal)
            layoutConstraintViewWebTop.constant = -SCREEN_HEIGHT
            layoutConstraintViewTitleTop.constant = -viewTitle.frame.size.height
            UIView.animate(withDuration: 0.4, delay: TimeInterval(INT_0), options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: {finished in
            })
        }
    }
    
    @IBAction func buttonAddTarget(_ sender: UIButton) {
        if (boolTargetAdded){
            sender.tintColor = .lightGray
            boolTargetAdded = false
            avTargetOperate.isHidden = false
            sender.isHidden = true
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: {timer in
                showTip(text: TEXT_CANCEL_TARGET_SUCCESS)
                self.avTargetOperate.isHidden = true
                sender.isHidden = false
            })
            
        }else{
            sender.tintColor = COLOR_TARGET_RED
            boolTargetAdded = true
            avTargetOperate.isHidden = false
            sender.isHidden = true
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: {timer in
                showTip(text: TEXT_ADD_TARGET_SUCCESS)
                self.avTargetOperate.isHidden = true
                sender.isHidden = false
            })
        }
    }
    
    // MARK: Function
    func fakeData(){
        
        let article2: ArticleListModel = ArticleListModel()
        article2.title = "New Title Here"
        article2.imageList = [IMG_NAME_PLACEHOLDER, IMG_NAME_PLACEHOLDER, IMG_NAME_PLACEHOLDER]
        article2.authorInfo.authorName = "NewAuthor"
        article2.articleType = CELL_ARTICLE_LIST_TYPE_A
        article2.targeted = false
        commentList.append(article2)
        
        let article3: ArticleListModel = ArticleListModel()
        article3.title = "New Title Here, It's a Long Title, Wrap Please. Wrap Wrap Wrap. More Lines, Maybe three Line. Other Line, Good Title"
        article3.targeted = false
        article3.imageList = [IMG_NAME_PLACEHOLDER, IMG_NAME_PLACEHOLDER, IMG_NAME_PLACEHOLDER]
        article3.authorInfo.authorName = "NewAuthor"
        article3.articleType = CELL_ARTICLE_LIST_TYPE_A
        commentList.append(article3)
        commentList.append(article2)
        commentList.append(article3)
        commentList.append(article2)
        commentList.append(article2)
        commentList.append(article2)
        commentList.append(article3)
        
        tableViewComment.reloadData()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
