//
//  ViewController.swift
//  BeltExam
//
//  Created by maram  on 16/06/1444 AH.
//

import UIKit


class LoginViewController: UIViewController {

    //MARK:- IBOuloets
    
    //Labels
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var haveAnAccount: UILabel!
    //TextField
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    
    //Button
    @IBOutlet weak var registerOutlet: UIButton!
    @IBOutlet weak var loinOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Variables
    var isLogin: Bool = false
    
    
    //MARK:- IBAction
    
    @IBAction func registerButton(_ sender: UIButton) {
        if isDataInputedFor(mode: isLogin ? "login" : "register"){
            
            isLogin ? loginUser() : registerUser()

            // ToDo:- Login or Register
            
            
           // register
         
            
            
        } else{
            let alert =  UIAlertController()
            let action = UIAlertAction(title: "error !!  all fileds are required", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func loinButton(_ sender: UIButton) {
        
        updateUIMode(mode: isLogin)



    }
    
    private func updateUIMode(mode: Bool){
        
        if !mode {
            titleOutlet.text = "Login"
            registerOutlet.setTitle("Login", for: .normal)
            loinOutlet.setTitle("Register", for: .normal)
            haveAnAccount.text = "New here?"
        } else {
            titleOutlet.text = "Register"
            registerOutlet.setTitle("Register", for: .normal)
            loinOutlet.setTitle("Login", for: .normal)
            haveAnAccount.text = "Have an account?"

        }
        isLogin.toggle()
    }
    //MARK:- Helper
    private func isDataInputedFor(mode: String) ->Bool {
        
        switch mode {
        case "login":
            return emailTextField.text != "" && passwordTextField.text != ""
            
        case "register":
            return emailTextField.text != "" && passwordTextField.text != ""
            
        default:
            return false
        }
    }
    
    //MARK:- Register User
    private func registerUser() {
       
            if passwordTextField.text! == confirmPass.text! {
                FireUser.shared.registerUserWith(email: emailTextField.text!, password: passwordTextField.text!) { (error) in
                    if error == nil {
                        let alert =  UIAlertController()
                        let action = UIAlertAction(title: " Verification email ", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        
    }
    
    
    //MARK:- Login User
    
    private func loginUser() {
        
    }
}

