//
//  ViewController.swift
//  YoutubeDemoApp
//
//  Created by Yury Popov on 27/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController, VideoModelDelegate {
        
    var videos: [Item]?
    var selectedVideo: Item?
    let videoModel = VideoModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoModel.delegate = self
        videoModel.getFeedVideos()
    }
    
    //MARK: -VideoModel Delegate Methods
    
    func dataRedy() {
        print(#function)
        videos = videoModel.videoObject?.items
        collectionView.reloadData()
        
        
    }
    
}


// MARK: UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let videos = videos else {
            return 0
        }
        print(#function)
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        let video = videos?[indexPath.row].snippet
        cell.videoTitleLabel.text = video?.title
        
        return cell
    }
    
    
}

// MARK: UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC {
//            vc.rssItem = rssItems?[indexPath.item]
//            present(vc, animated: true)
//        }
    }
}

