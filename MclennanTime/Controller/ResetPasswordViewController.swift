//
//  ResetPasswordViewController.swift
//  MclennanTime
//
//  Created by Alex Ference on 2020-02-01.
//  Copyright © 2020 Alex Ference. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func resetButtonPressed(_ sender: Any) {
        if let email = emailTextField.text {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let e = error {
                    print("email not registered in our system \(e)")
                    let alertController = UIAlertController(title: "Error", message:
                        "Email not found in system", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                    self.present(alertController, animated: true, completion: nil)
                }
                else {
                    print("reset email was sent succesfully")
                    let alertController = UIAlertController(title: "Check your email", message:
                        "Reset email has been sent succesfully", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))

                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
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
