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
    
    var post: Post!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: Post) {
        self.post = post
        self.captionTextView.text = post.caption
        self.likesLabel.text = "\(post.likes)"
    }
}
