//
//  ChatRoomVC.swift
//  Clerkie Project
//
//  Created by Jing on 2017/11/10.
//  Copyright © 2017年 Jing. All rights reserved.
//

import UIKit

/* VC for register interface
 */
class ChatRoomVC: UITableViewController {
    let imageArray = [#imageLiteral(resourceName: "Iris.jpg"), #imageLiteral(resourceName: "Daris.jpg"), #imageLiteral(resourceName: "Michelle.jpg")]
    let nameArray = ["Iris", "Daris", "Michelle"]
    let idArray = ["-1", "-2", "-3"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatTableViewCell
        cell.userImg.image = imageArray[indexPath.row]
        cell.usernameLabel.text = nameArray[indexPath.row]
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination
        if let identifier = segue.identifier {
            if identifier == "showChat" {
                if let chatVC = destinationVC as? ChatVC {
                    if let cell = sender as? ChatTableViewCell {
                        if let index = tableView.indexPath(for: cell)?.row {
                            chatVC.friendImg = imageArray[index]
                            chatVC.title = nameArray[index]
                            chatVC.friendName = nameArray[index]
                            chatVC.friendId = idArray[index]
                        }
                    }
                }
            }
        }
    }
}
