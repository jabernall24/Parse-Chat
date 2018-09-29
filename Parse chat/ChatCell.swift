//
//  ChatCell.swift
//  Parse chat
//
//  Created by Jesus Andres Bernal Lopez on 9/29/18.
//  Copyright © 2018 Jesus Andres Bernal Lopez. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var chatMessageLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    
    let padding: CGFloat = 2
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        chatMessageLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
        bubbleView.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        bubbleView.layer.cornerRadius = 16
        
        usernameLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
