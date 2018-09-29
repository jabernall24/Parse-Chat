//
//  Message.swift
//  Parse chat
//
//  Created by Jesus Andres Bernal Lopez on 9/29/18.
//  Copyright © 2018 Jesus Andres Bernal Lopez. All rights reserved.
//

import UIKit
import Parse

class Message: PFObject, PFSubclassing{
    
    @NSManaged var text: String!
    @NSManaged var user: PFUser!
    
    static func parseClassName() -> String {
        return "Message"
    }
    

}
