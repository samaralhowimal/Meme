//
//  Tableviewcell.swift
//  MemeMe
//
//  Created by samar on 22/03/1440 AH.
//  Copyright © 1440 udacity. All rights reserved.
//

import Foundation
import UIKit

class VideoTableViewCell: UITableViewCell
{
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var video: Video! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        thumbnailImageView.image = UIImage(named: video.thumbnailFileName)
        thumbnailImageView.layer.cornerRadius = 8.0
        thumbnailImageView.layer.masksToBounds = true
        
        usernameLabel.text = video.authorName
    }
}
