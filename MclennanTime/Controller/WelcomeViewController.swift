//
//  WelcomeViewController.swift
//  MclennanTime
//
//  Created by Alex Ference on 2020-02-01.
//  Copyright © 2020 Alex Ference. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class WelcomeViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime = 200
    var secondsPassed = 0
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        navigationItem.setHidesBackButton(true, animated: true);
        
//        if let uid = Auth.auth().currentUser?.uid {
//            let docRef = db.collection(K.usersCollection).document(uid)
//            docRef.getDocument { (document, error) in
//                        if let document = document, document.exists {
//                            let dataDescription = document.data()
//                            if let name = dataDescription?[K.FStore.nameField] {
//                                self.welcomeLabel.text = "Welcome \(name)"
//                            }
//                        } else {
//                            print("Document does not exist")
//                        }
//            }
//        }
 
        
        //use documet.numchildren method to get total # of people in the library right now
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
     @IBAction func startButtonPressed(_ sender: UIButton) {
        print("Hello")
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
        
     }
    
    @objc func updateTimer() {
        timeDisplay(s: totalTime - secondsPassed)
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressView.progress = Float(secondsPassed) /
                Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime))
        } else {
            timer.invalidate()
            timeLabel.text = "DONE!"
            
            //let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            //player = try! AVAudioPlayer(contentsOf: url!)
            //player.play()
        }
    }
    
    func timeDisplay(s:Int) {
        var minutes = s/60
        var seconds = s%60
        if seconds < 10 {
            timeLabel.text = "\(minutes):0\(seconds)"
        }
        else {
            timeLabel.text = "\(minutes):\(seconds)"
        }
        
    }
     

}
