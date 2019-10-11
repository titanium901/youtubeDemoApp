//
//  VideoModel.swift
//  YoutubeDemoApp
//
//  Created by Yury Popov on 27/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit
import Alamofire

protocol VideoModelDelegate {
    func dataRedy()
}

class VideoModel: NSObject {
   
    
    let API_KEY = "AIzaSyASNaF2m2cEKiKasAGZlk1fTtHX39MbzO0"
    var videoObject: Video?
    
    var delegate: VideoModelDelegate?
    
    func getFeedVideos() {
        
        AF.request("https://www.googleapis.com/youtube/v3/playlistItems", method: .get, parameters: ["part": "snippet", "maxResults": "40", "playlistId": "UUt7sv-NKh44rHAEb-qCCxvA", "key": API_KEY], encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil).responseJSON { (response) in
            
            switch response.result {
            case .success:
                if let jsonData = response.data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let video = try jsonDecoder.decode(Video.self, from: jsonData)
                        self.videoObject = video
                        if self.delegate != nil {
                            self.delegate?.dataRedy()
                        }
                        
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error)
            }
            
        }
    
    }
    
    
    
}
