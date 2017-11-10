//
//  ChatTableViewCell.swift
//  Clerkie Project
//
//  Created by Jing on 2017/11/10.
//  Copyright © 2017年 Jing. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        userImg.image = #imageLiteral(resourceName: "brooke-cagle-171800")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
}
