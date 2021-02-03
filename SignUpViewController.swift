//
//  SignUpViewController.swift
//  CrossingApp
//
//  Created by Abigail Taylor on 7/22/20.
//  Copyright © 2020 Abigail Taylor. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField! 
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        //hide the error label
        errorLabel.alpha = 0
        
        //style the elements
        Utilities.styleTextField(firstNameTextField)
        
        Utilities.styleTextField(lastNameTextField)
        
        Utilities.styleTextField(emailTextField)
        
        Utilities.styleTextField(passwordTextField)
        
        Utilities.styleFilledButton(signUpButton)
        
    }

    //check the fields and validate that the data is correct. if everything is correct, this method returns nill. otherwise, it returns the error message as a string into the label
    func validateFields() -> String? {
        
        //check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        //check if password is secure..method from utlities file
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at east 8 characters, contains a special character and a number"
        }
        
        return nil
    }
    @IBAction func signUpTapped(_ sender: Any) {
        //validate the fields
        let error = validateFields()
        
        if error != nil {
            //if error isnt equal  to nil, then there is an error, so show error message
            showError(error!)
            
        }
        else{
            //create cleaned versions of the data by stripping out whitespaces
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        //create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //chec for errors
                if err != nil{
                    //if error comes in here then there was an eror creating the user
                    self.showError("Error creating user")
                }
                else{
                    //user was creating successfully, now store the first and last name
                    let db = Firestore.firestore()
                    db.collection("users").document(result!.user.uid).setData( ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil{
                            //show error message
                            //at this point, user was created and is in system but their name couldnt be saved in database side
                            self.showError("Error saving user data")
                        }
                    }
                    //transition to home screen
                    self.transitionToHome()
                }
            }
        
        
        }
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
