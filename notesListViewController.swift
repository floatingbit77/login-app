//
//  notesListViewController.swift
//  CrossingApp
//
//  Created by Abigail Taylor on 7/31/20.
//  Copyright © 2020 Abigail Taylor. All rights reserved.
//

import UIKit

class notesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!

    var notes: [String] = []
//    var txt: String!
    
    let textCellIdentifier = "TextCell"
    
    override func viewDidLoad() {

        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
     
        let row = indexPath.row
        cell.textLabel?.text = notes[row]
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
     
        let row = indexPath.row
        print(notes[row])
    }


}
