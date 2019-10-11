//
//  DetailVC.swift
//  YoutubeDemoApp
//
//  Created by Yury Popov on 11.10.2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit
import WebKit

class DetailVC: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    var video: Item?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        
        if let item = video {
            titleLabel.text = item.snippet.title
            descriptionText.text = item.snippet.snippetDescription
            if let url = URL(string: "http://www.youtube.com/embed/\(item.snippet.resourceID.videoID)") {
                webView.load(URLRequest(url: url))
            }
            
        }
    }


}

extension DetailVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
