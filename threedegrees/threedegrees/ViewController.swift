//
//  ViewController.swift
//  threedegrees
//
//  Created by Brian Yang on 11/14/15.
//  Copyright © 2015 NickBrian^2. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var estimatedPercentage: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var navigation: UINavigationItem!
    
    // MARK: Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigation.title = "3Degrees"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // allow user to find an image on their device
    @IBAction func selectImageAction(sender: UIButton) {
        estimatedPercentage.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // only allow photos to be taken
        imagePickerController.sourceType = .PhotoLibrary
        
        // notify view controller when image picked
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    // image selection canceled
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // User selected an image so display it
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let selectedImageGallery = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        selectedImage.image = selectedImageGallery
        
        // change select image button to say select another
        selectButton.setTitle("Select another image", forState: .Normal)
        
        // only allow submission when an image is selected
        submitButton.enabled = true
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
        
    }

}

