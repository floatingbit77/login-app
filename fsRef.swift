//
//  fsRef.swift
//  CrossingApp
//
//  Created by Abigail Taylor on 7/24/20.
//  Copyright © 2020 Abigail Taylor. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class fsRef {

    static var notes : [String] = []
    /*
     function to add a note to users database
    @param nTitle the title of the note
     @param nContent the content of the note stored within the title
    */
   static func saveNoteDetails(nTitle:String, nContent:String){
           
           let db = Firestore.firestore()
    
           let userID = Auth.auth().currentUser!.uid;


           print (userID)
           
           
           let docData =  //[
             //  "insert timestamp" :
                   [
                       "title": nTitle,
                       "content" : nContent
                   ]
    
           
      // db.collection("users").document(userID).setData(docData)
       db.collection(userID).document(nTitle).setData(docData){ err in
               if let err = err {
                   print("Error writing document: \(err)")
               } else {
                   print("Document successfully written!")
               }
           }
     //      let ref = db.collection("cities").document().documentID
   }
    
    static func addToArray(title: String){
        notes.append(title)
    }

    static func printArray(){
        print(notes)
    }
}

