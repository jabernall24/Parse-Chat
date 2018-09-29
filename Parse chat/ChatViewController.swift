//
//  ChatViewController.swift
//  Parse chat
//
//  Created by Jesus Andres Bernal Lopez on 9/29/18.
//  Copyright © 2018 Jesus Andres Bernal Lopez. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var chatMessageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    var messages: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.separatorStyle = .none
        tableView.insertSubview(refreshControl, at: 0)
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        didPullToRefresh(refreshControl)
        
        fetchMessages()
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        if let message = messages[indexPath.row].object(forKey: "text"){
            cell.chatMessageLabel.text = message as? String
        }else{
            cell.chatMessageLabel.text = " "
        }
        if let user = messages[indexPath.row].object(forKey: "user") as? PFUser{
            cell.usernameLabel.text = user.username
        }else{
            cell.usernameLabel.text = "🤖"
        }

        return cell
    }
    
    func fetchMessages(){
        let query = PFQuery(className: "Message")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.limit = 20
        query.findObjectsInBackground { (message: [PFObject]?,error: Error?) in
            if let message = message{
                self.messages = message
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }else{
                print(error?.localizedDescription ?? "Unknown error")
            }
        }
    }
    
    @IBAction func onSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        
        chatMessage.saveInBackground { (success: Bool, error: Error?) in
            if success{
                self.chatMessageField.text = ""
                
            }else{
                print(error?.localizedDescription ?? "Unknown error")
            }
        }
    }
    @IBAction func onTap(_ sender: Any) {
        chatMessageField.resignFirstResponder()
    }
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            if error == nil{
                self.performSegue(withIdentifier: "logOutSegue", sender: self)
            }else{
                print(error?.localizedDescription ?? "Unknown error")
            }
        }
    }
    
    @objc func onTimer(){
        fetchMessages()
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchMessages()
    }
}
