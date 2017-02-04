//
//  PostCell.swift
//  devlopes-social
//
//  Created by Marissa Dietz on 1/23/17.
//  Copyright © 2017 Carter Apps. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var profileImage:UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var captionTextView: UITextView!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    
    @IBOutlet weak var postImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
