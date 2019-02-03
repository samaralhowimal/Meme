//
//  ImageTableViewController.swift
//  MemeMe
//
//  Created by samar on 22/03/1440 AH.
//  Copyright © 1440 udacity. All rights reserved.
//

import Foundation

import UIKit

class ImageTableViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    
    
    
    
    var memes : [Meme] = fetchImges()
    
    
    
// MARK: - UITableViewDataSource

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Images.count
    
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath) as! ImageTableViewCell
    let Meme = Images[indexPath.row]
    
    cell.Meme = Meme
    
    return cell
}

// MARK: - UITableViewDelegate

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 250
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
}
}
