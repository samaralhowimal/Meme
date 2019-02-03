//
//  DetailViewController.swift
//  MemeMe
//
//  Created by samar on 02/04/1440 AH.
//  Copyright © 1440 udacity. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    
     @IBOutlet weak var imageView: UIImageView!
    var meme: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imageView.image = meme
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

}
