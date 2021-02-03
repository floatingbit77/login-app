//
//  MenuListController.swift
//  CrossingApp
//
//  Created by Abigail Taylor on 7/22/20.
//  Copyright © 2020 Abigail Taylor. All rights reserved.
//

import UIKit
import SideMenu

//class for table view  inside of  the main  menu swipe
class MenuListController: UITableViewController{
    
    var  items = ["Notes", "Profile"]
    
    //make the menu a dark grey backtground color
    let darkColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //set entire table view background
        tableView.backgroundColor = darkColor
        //register a cell as the  table view's  cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    //implement number of rows and return items
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row] //set the text to the element at given position
        //make text color white
        cell.textLabel?.textColor = .white
        //set  background color of cell
        cell.backgroundColor = darkColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //highlight cell when clicking on it to select it
        tableView.deselectRow(at: indexPath, animated: true)
                
        print(self.items[indexPath.row])
        
        
        //do something
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if(indexPath.row == 0){
                print("YAYYY")
                let firstVC = storyBoard.instantiateViewController(withIdentifier: "NotesVC") as! NotesListTableViewController
                    //self.present(firstVC, animated: true, completion: nil)
                //self.show(firstVC, sender:self)
                self.showDetailViewController(firstVC, sender: self)
                }
        }
        
}
    
        
