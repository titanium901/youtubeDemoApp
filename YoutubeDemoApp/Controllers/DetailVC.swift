//
//  DetailVC.swift
//  YoutubeDemoApp
//
//  Created by Yury Popov on 11.10.2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit
import WebKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    var video: Item?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let item = video {
            titleLabel.text = item.snippet.title
            descriptionText.text = item.snippet.snippetDescription
            let width = self.view.frame.width
            let height = self.view.frame.height
            let videoEmbedString = "<html><head><style type=\"text/css\">body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><iframe frameBorder=\"0\" height=\"180\" width=\"320\" src=\"http://www.youtube.com/embed/" + item.snippet.resourceID.videoID + "?showinfo=0&modestbranding=1&frameborder=0&rel=0\"></iframe></body></html>"
            webView.loadHTMLString(videoEmbedString, baseURL: nil)
        }
    }


}
