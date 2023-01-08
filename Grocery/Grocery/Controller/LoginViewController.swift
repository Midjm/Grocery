//
//  ViewController.swift
//  Grocery
//
//  Created by maram  on 15/06/1444 AH.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    //Variables
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorlabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var singbutt: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        
    }
    func setUpElements(){
        
        //hide the error label
        errorlabel.alpha = 0
        
//        //style the elements
//        Utilities.styleTextField(emailTextField)
//        Utilities.styleTextField(passwordTextField)
//        Utilities.styleFilledButton(loginButton)

}
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //signing in user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil{
                //fail to sign in
                self.showError("Incorrect Email/Password Combination")
                
            }
            else{ //go to next vc
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "allGroceryViewController") as? GroceryViewController
                self.view.window?.rootViewController = nextVC
                self.view.window?.makeKeyAndVisible()
            }
        }

    }
    

    
    //Display error message
    func showError( _ message: String ){
        errorlabel.text = message
        errorlabel.alpha = 1
    }
}




