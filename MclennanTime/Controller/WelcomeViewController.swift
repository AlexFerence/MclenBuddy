//
//  WelcomeViewController.swift
//  MclennanTime
//
//  Created by Alex Ference on 2020-02-01.
//  Copyright © 2020 Alex Ference. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        navigationItem.setHidesBackButton(true, animated: true);
        
        if let uid = Auth.auth().currentUser?.uid {
            let docRef = db.collection(K.usersCollection).document(uid)
            docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let dataDescription = document.data()
                            if let name = dataDescription?[K.FStore.nameField] {
                                self.welcomeLabel.text = "Welcome \(name)"
                            }
                        } else {
                            print("Document does not exist")
                        }
            }
        }
 
        
        

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

}
