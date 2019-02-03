//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by samar on 19/03/1440 AH.
//  Copyright © 1440 udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController:UICollectionViewController {


var memes = [Meme]?{
    
    let object = UIApplication.shared.delegate
    let appDelegate = object as! AppDelegate
    return AppDelegate.memes
}
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
