//
//  ArticleViewController.swift
//  Feeding
//
//  Created by zhaochenjun on 2017/5/8.
//  Copyright © 2017年 com.kazmastudio. All rights reserved.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController, UIScrollViewDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var layoutConstraintLabelAuthorTop: NSLayoutConstraint!
    @IBOutlet weak var viewAuthor: UIView!
    @IBOutlet weak var viewWebViewBase: UIView!
    @IBOutlet weak var layoutConstraintVisualViewBottomHeight: NSLayoutConstraint!
    @IBOutlet weak var viewTopHeight: NSLayoutConstraint!
    @IBOutlet weak var visualEffectViewTop: UIVisualEffectView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var layoutConstraintVisualEffectViewBottomBottom: NSLayoutConstraint!
    var webViewMain: WKWebView!
    
    var WEB_VIEW_SCROLL_VIEW_OFFSET_Y = CGFloat(INT_0)
    var VISUAL_EFFECT_VIEW_TOP_HEIGHT = CGFloat(INT_0)
    let VIEW_TOP_MIN_HEIGHT = UIApplication.shared.statusBarFrame.height
    let LABEL_TITLE_MAX_FONT_SIZE = CGFloat(INT_14)
    let LABEL_TITLE_MIN_FONT_SIZE = CGFloat(INT_12)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isStatusBarHidden = true
        webViewMain = WKWebView.init()
        webViewMain.scrollView.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        labelTitle.text = "这是个新标题，一个中文标题。这而且是个很长很长的标题，换行，换行，继续换行。超长的标题，又要换行了"
        webViewMain.load(URLRequest.init(url: URL.init(string: "https://www.mapbox.com")!))
        webViewMain.scrollView.delegate = self
        webViewMain.navigationDelegate = self
        WEB_VIEW_SCROLL_VIEW_OFFSET_Y = -viewTopHeight.constant
        VISUAL_EFFECT_VIEW_TOP_HEIGHT = viewTopHeight.constant
        webViewMain.scrollView.contentInset = UIEdgeInsets.init(top: 0, left: CGFloat(INT_0), bottom: layoutConstraintVisualViewBottomHeight.constant, right: CGFloat(INT_0))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        UIApplication.shared.isStatusBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        
        webViewMain.frame = viewWebViewBase.bounds
        viewWebViewBase.addSubview(webViewMain)
        if(self.tabBarController?.tabBar.isHidden)!{
            layoutConstraintVisualEffectViewBottomBottom.constant = CGFloat(INT_0)
        }else{
            layoutConstraintVisualEffectViewBottomBottom.constant = CGFloat(-TAB_BAR_HEIGHT)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let targetViewTopHeight = VISUAL_EFFECT_VIEW_TOP_HEIGHT - scrollView.contentOffset.y
        if(targetViewTopHeight < VIEW_TOP_MIN_HEIGHT){
            viewTopHeight.constant = VIEW_TOP_MIN_HEIGHT
            labelTitle.font = UIFont.boldSystemFont(ofSize: LABEL_TITLE_MIN_FONT_SIZE)
            layoutConstraintLabelAuthorTop.constant = 96
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
            if (targetViewTopHeight > 136){
                layoutConstraintLabelAuthorTop.constant = targetViewTopHeight-40
            }else{
                layoutConstraintLabelAuthorTop.constant = 96
            }
        }
        self.webViewMain.scrollView.scrollIndicatorInsets = UIEdgeInsets.init(top: viewTopHeight.constant, left: CGFloat(INT_0), bottom: layoutConstraintVisualViewBottomHeight.constant, right: CGFloat(INT_0))
        print(scrollView.contentOffset.y)
    }
    
    @IBAction func buttonBackTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
