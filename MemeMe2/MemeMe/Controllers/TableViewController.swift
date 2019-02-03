//
//  TableViewController.swift
//  MemeMe
//
//  Created by samar on 19/03/1440 AH.
//  Copyright © 1440 udacity. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{
    
    
  
    var memes :[Meme]? {
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
    override func viewWillAppear(_ animated: Bool) {
      tableView.reloadData()
    }
    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes!.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! ImageTableViewCell
        
        let meme = memes! [indexPath.row]
        
        cell.ImageView?.image = meme.memedImage
        cell.title?.text = "\(meme.topText!) ... \(meme.bottomText!)"
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
        let detailController = storyboard!.instantiateViewController(withIdentifier: "DetailView") as! MemeDetailViewController
        
        
        detailController.meme = memes![indexPath.row].memedImage
        
       
        navigationController!.pushViewController(detailController, animated: true)
        
    }

   
}
