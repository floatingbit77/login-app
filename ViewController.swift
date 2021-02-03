//
//  ViewController.swift
//  CrossingApp
//
//  Created by Abigail Taylor on 7/22/20.
//  Copyright © 2020 Abigail Taylor. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    var videoPlayer:AVPlayer?
    //managers visual output
    var  videoPlayerLayer:AVPlayerLayer?
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    override func viewWillAppear(_ animated: Bool){
        //set up video in background
        setUpVideo()
    }
    
    func setUpElements(){
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }

    func setUpVideo(){
        //get the path to he resrouce in the bundle
        let bundlePath = Bundle.main.path(forResource: "startvid", ofType: "mp4")
        
        guard bundlePath != nil else {
            return
        }
        
        //create a url from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        //create the video player item
        let item = AVPlayerItem(url: url)

        
        //create  the player
        videoPlayer = AVPlayer(playerItem: item)
        
        //create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        
        //adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
         //videoPlayerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)

        view.layer.insertSublayer(videoPlayerLayer!, at:0)
        
        //add it to the view  and play  it
        videoPlayer?.playImmediately(atRate: 0.3)
        
 //       NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.videoPlayer?.currentItem, queue: .main) { _ in
 //           self.videoPlayer?.seek(to: CMTime.zero)
 //           self.videoPlayer?.playImmediately(at rate: 0.3)
  //      }
        
        }
    }



