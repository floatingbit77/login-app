//
//  HomeViewController.swift
//  CrossingApp
//
//  Created by Abigail Taylor on 7/22/20.
//  Copyright © 2020 Abigail Taylor. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
import FirebaseAuth


class HomeViewController: UIViewController {

    
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Utilities.backgroundGrey
        //hide sidemenu window
        menuView.alpha =  0
        
        //hide label
        welcomeLabel.alpha = 0

        //Do any additional setup after loading the view.
        welcomeName()
        
    }
    
 func welcomeName() {

     let d = Firestore.firestore()
     if let userId = Auth.auth().currentUser?.uid {

        d.collection("users").getDocuments() { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
         //do something
                if let currentUserDoc = snapshot?.documents.first(where: { ($0["uid"] as? String) == userId }) {
                    var welcomeName = currentUserDoc["firstname"] as! String
                    self.welcomeLabel.alpha = 1
                    self.welcomeLabel.text = "Welcome, \(welcomeName) !"
                    self.welcomeLabel?.textColor = Utilities.blueColor
                    self.welcomeLabel.textAlignment = .center
                    self.welcomeLabel.font = UIFont.init(name: "AmericanTypewriter", size: 28.00)
                    
          }

             }
         }
     }
 }
    
    func showView(){
        menuView.alpha = 1
    }
    
    func hideView(){
        menuView.alpha = 0
    }
    
    var counter = 0
    @IBAction func showMenuOps(_ sender: UIBarButtonItem) {
        if (counter % 2 == 0) {
            showView()
            counter += 1
        }
        else if (counter % 2 == 1) {
            hideView()
            counter += 1
        }
  //      menuView.alpha = 1
    }
    

    
    @IBAction func rightGesture(_ sender: UISwipeGestureRecognizer) {
        menuView.alpha = 1
        print("right swipe")
    }
    
    @IBAction func leftGesture(_ sender: UISwipeGestureRecognizer) {
        menuView.alpha = 0
        print("left swipe")
    }
    
    
}
