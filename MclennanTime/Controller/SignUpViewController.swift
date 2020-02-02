//
//  SignInViewController.swift
//  MclennanTime
//
//  Created by Alex Ference on 2020-02-01.
//  Copyright © 2020 Alex Ference. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUpButtonPressed(_ sender: Any) {
        
        if let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print("error \(e)")
                    let alertController = UIAlertController(title: "Error", message:
                        e.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                }
                else {
                    print("user authenticated succesfully")
                    if let uid = Auth.auth().currentUser?.uid {
                        self.db.collection(K.usersCollection).document(uid).setData([
                            K.FStore.emailField: email,
                            K.FStore.nameField: name
                        ])
                        self.performSegue(withIdentifier: K.segueSignInToLocation, sender: self)
                    }
                    
                    
                    
                    
                    
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
