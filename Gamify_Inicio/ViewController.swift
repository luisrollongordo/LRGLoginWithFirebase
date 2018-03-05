//
//  ViewController.swift
//  Gamify_Inicio
//
//  Created by Luis Rollon Gordo on 8/12/16.
//  Copyright © 2016 EfectoApple. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var loginEmailField: UITextField!
    @IBOutlet weak var loginPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {

        //1.
        let alert = UIAlertController(title: "Nuevo Usuario",
                                      message: "Introduce tus datos por favor",
                                      preferredStyle: .alert)
        //2.
        let saveAction = UIAlertAction(title: "Guardar",
                                       style: .default) { action in
                                        let emailField = alert.textFields![0]
                                        let passwordField = alert.textFields![1]
                                        //3.
                                        FIRAuth.auth()!.createUser(withEmail: emailField.text!,
                                                                   password: passwordField.text!) { user, error in
                                        }
        }
        //4.
        let cancelAction = UIAlertAction(title: "Cancelar",
                                         style: .default)
        //5.
        alert.addTextField { textEmail in
            textEmail.placeholder = "email"
        }
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "contraseña"
        }
        //6.
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        //7.
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        //1.
        if self.loginEmailField.text == "" || self.loginPasswordField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Por favor introduce email y contraseña", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
        //2.
            FIRAuth.auth()?.signIn(withEmail: self.loginEmailField.text!, password: self.loginPasswordField.text!) { (user, error) in
        //3.
                if error == nil {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
        //4.
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

