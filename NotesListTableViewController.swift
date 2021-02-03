//
//  NotesListTableViewController.swift
//  CrossingApp
//
//  Created by Abigail Taylor on 7/22/20.
//  Copyright © 2020 Abigail Taylor. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

protocol DocumentSerializeable {
    init?(dictionary:[String:Any])
}

struct Source {
    var title: String
    var content: String
 //   var timeStamp: Date

    var dictionary: [String: Any] {
        return [
            "title": title,
            "content": content,
     //       "timestamp": timeStamp
        ]
    }
}


extension Source : DocumentSerializeable {
    init?(dictionary: [String : Any]) {
        guard let title = dictionary["title"] as? String,
            let content = dictionary["content"] as? String else {return nil}
       //     let timeStamp = dictionary["timeStamp"] as? Date else {return nil}
        
        self.init(title: title, content: content)

    }
}




class NotesListTableViewController: UITableViewController {
 
    var notes: [Note] = []
    var sourceArray = [Source]()
    
    private var document: [DocumentSnapshot] = []
    
    var db: Firestore!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        db = Firestore.firestore()
        loadData()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tableView.reloadData()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // Return the number of rows in the section.
       // return notes.count
        return sourceArray.count 

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath) as UITableViewCell
        
   //     cell.textLabel!.text = notes[indexPath.row]
 //       cell.textLabel?.text = "section \(indexPath.section) Row \(indexPath.row)"
     //   cell.textLabel!.text = fsRef.notes[indexPath.row]
        let source = sourceArray[indexPath.row]
        cell.textLabel?.text =  "\(source.title)"
            //.title
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
 //   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
  //      notes.remove(at: indexPath.row)
   //     tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        
  //  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier! == "showNote" {
        var noteDetailViewController = segue.destination as! NoteDetailViewController
           var selectedIndexPath = tableView.indexPathForSelectedRow
           noteDetailViewController.note = sourceArray[selectedIndexPath!.row]
       } else if segue.identifier! == "addNote" {
        var note = Source(title: "", content: "")//makes a blank note with title and content as """" as in class definition
           sourceArray.append(note) //add the note to the array
        var noteDetailViewController = segue.destination as! NoteDetailViewController
           noteDetailViewController.note = note
    

       }
}
    
    func loadData() {
        db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.uid
        db.collection(userID!).getDocuments { (snapshot, error) in
            if let error = error{
                print(error.localizedDescription)
            }
            else{
                
                if let snapshot = snapshot{
                    for document in snapshot.documents{
                        let data = document.data()
                        let title = data["title"] as? String ?? ""
                        let content = data["content"] as? String ?? ""
                        let newSource = Source(title:title, content:content)
                        self.sourceArray.append(newSource)
                    }
                    self.tableView.reloadData()
                }
            }
       
    }
    }
    
   
}

