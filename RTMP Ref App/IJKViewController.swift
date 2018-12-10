//
//  IJKViewController.swift
//  RTMP Ref App
//
//  Created by CPU11613 on 12/3/18.
//  Copyright © 2018 AntMedia. All rights reserved.
//

import UIKit
import IJKMediaFramework

class IJKViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    var player: IJKMediaPlayback?
    var url: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.player = IJKFFMoviePlayerController.init(contentURLString: self.url!, with: nil)
        player?.view.frame = self.view.bounds
        view.addSubview((player?.view)!)
        player?.prepareToPlay()
        player?.play()
        (player as! IJKFFMoviePlayerController?)!.shouldShowHudView = true
        self.view.bringSubview(toFront: self.doneButton)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player?.stop()
        player = nil
    }
    
    static func instance(url: String) -> IJKViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Player") as! IJKViewController
        vc.url = url
        
        return vc
    }
    
    @IBAction func doneTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
