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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var videos: [Item]?
    var selectedVideo: Item?
    let videoModel = VideoModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImage.layer.borderWidth = 1
        logoImage.layer.borderColor = UIColor.black.cgColor
        videoModel.delegate = self
        videoModel.getFeedVideos()
    }
    
    
    //MARK: -VideoModel Delegate Methods
    
    func dataRedy() {
        videos = videoModel.videoObject?.items
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        collectionView.reloadData()
        print(videos!)
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
        if let url = video?.thumbnails.maxres.url {
            cell.videoImage.sd_setImage(with: URL(string: url))
        }
        return cell
    }
    
    
   
    
}

// MARK: UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC {
            vc.video = videos?[indexPath.row]
            
            present(vc, animated: true)
        }
    }
    
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                    layout collectionViewLayout: UICollectionViewLayout,
                    sizeForItemAt indexPath: IndexPath) -> CGSize {
    let referenceHeight: CGFloat = 300 // Approximate height of the cell
    // Cell width calculation
    let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
    let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
        - sectionInset.left
        - sectionInset.right
        - collectionView.contentInset.left
        - collectionView.contentInset.right

        return CGSize(width: referenceWidth, height: referenceHeight)
    }
}

