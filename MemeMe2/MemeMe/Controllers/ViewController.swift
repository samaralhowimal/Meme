//
//  ViewController.swift
//  MemeMe
//
//  Created by samar on 09/03/1440 AH.
//  Copyright © 1440 udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate{
    
    
    
    
    @IBOutlet weak var imagePickerView: UIImageView!
 
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var Album: UIBarButtonItem!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var ToptextField: UITextField!
    
    
    @IBOutlet weak var BottomtextField: UITextField!
    
    
    @IBOutlet weak var TopToolbar: UIToolbar!
    
    
    @IBOutlet weak var BottomToolbar: UIToolbar!
    
    var memedImage:UIImage?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(textField: BottomtextField, withText: "BOTTOM")
        configure(textField: ToptextField, withText: "TOP")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        if let _ = imagePickerView.image {
            shareButton.isEnabled = true
        } else {
            shareButton.isEnabled = false
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func configure(textField :UITextField, withText text: String){
        
        let memeTextAttributes:[ NSAttributedString.Key: Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue): UIColor.black,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): -3.0]
        
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        textField.text = text
    }
    
    
    func configureBars(hiddenBar:Bool){
        TopToolbar.isHidden = hiddenBar
        BottomToolbar.isHidden = hiddenBar
    }
    
    
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    @objc func keyboardWillHide(_ notification: Notification){
        view.frame.origin.y = 0
    }
    
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if (BottomtextField.isFirstResponder && view.frame.origin.y == 0){
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    
    
    func textFieldShouldReturn(_ textField:UITextField)-> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    
    
    func presentImagePickerWith(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated:true, completion:nil)
    }
    
    
    @IBAction func pickAnImageFromAlbum (_ sender:Any){
        presentImagePickerWith(sourceType: .photoLibrary)
        
        
    }
    
    @IBAction func pickImageFromCamera(_sender:Any){
        presentImagePickerWith(sourceType: .camera)
        
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: {
            self.navigationController?.popToRootViewController(animated: true)
        })
    }
    
    @IBAction func shareAction(_ sender: Any) {
        
        memedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage!], applicationActivities: nil)
        activityController.completionWithItemsHandler = {activity, success, items, error in
            if success{
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        present(activityController, animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ piker:UIImagePickerController){
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ piker:UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerController(piker , pickedImage: image)
            piker.dismiss(animated: true, completion: nil)
            
        }
        
        
        
    }
    
    @objc   func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?){
        imagePickerView.contentMode = .scaleAspectFit
        imagePickerView.image = pickedImage
    }
    
    func save() {
       
        let meme = Meme(topText: ToptextField.text!, bottomText: BottomtextField.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
     
        let object = UIApplication.shared.delegate
        
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)

    }
    
    func generateMemedImage() -> UIImage {
        configureBars(hiddenBar: true)
        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        configureBars(hiddenBar: false)
        return memedImage
    }
    
    
}
