//
//  LoginViewController.swift
//  Intagram-Tecsup-LGuzman
//
//  Created by MAC35 on 21/10/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPassword.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTabLogin(_ sender: UIButton) {
        if txtEmail.text == "" || txtPassword.text == ""{
            let alert = UIAlertController(title: "Error" , message: "Completa los campos",preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "ok" , style: .default)
            alert.addAction(alertButton)
            present(alert, animated: true)
            return
        }
        signIn(email: txtEmail.text!, password:txtPassword.text!)
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email , password: password) { authResult, error in
            if error == nil {
                
            }else {
                self.signUp(email: email, password: password)
            }
        }
    }
    func signUp(email : String , password : String){
        Auth.auth().createUser(withEmail: email, password: password) { AuthResult, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message : error?.localizedDescription, preferredStyle:.alert)
                let alertButton = UIAlertAction(title: "ok" , style: .default)
                alert.addAction(alertButton)
            }else{
            
        }
    }
 }
}
