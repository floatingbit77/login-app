//
//  NoteDetailViewController.swift
//  
//
//  Created by Abigail Taylor on 7/22/20.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class NoteDetailViewController: UIViewController {

    var note: Source!

    
    @IBOutlet weak var titleTextField: UITextField!

    @IBOutlet weak var contentTextView: UITextView!
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleTextField.text = note.title
        contentTextView.text = note.content

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        note.title = titleTextField.text!
        note.content = contentTextView.text
    }
    
    @IBAction func saveNote(_ sender: UIBarButtonItem) {
        let content = contentTextView!.text
        let title = titleTextField!.text
        fsRef.saveNoteDetails(nTitle: title!, nContent: content!)
        
      
    //    print(vc.notes)
        getDoc()
        

               }
    

    func getDoc(){
        let userID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        let docRef = db.collection(userID!).document(titleTextField!.text!)
//        let db1 = Firestore.firestore().collection(userID!)

       docRef.getDocument { (document, error) in
           if let document = document, document.exists {
               let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
               print("Document data: \(dataDescription)")
 //           let tString = self.titleTextField.text!
 //           let ref = db1.whereField("title", isEqualTo: tString)
  //          print(ref)
            let property = document.get("title")
            print(property!)
            let property1 = document.get("content")
            print(property1!)

            fsRef.addToArray(title: self.titleTextField!.text!)
            fsRef.printArray()
            
           } else {
               print("Document does not exist")
           }
        
       }
        
        
        }
    
    
    

    
    

    
     
    }
        
        
        
    

