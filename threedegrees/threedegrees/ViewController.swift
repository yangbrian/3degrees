//
//  ViewController.swift
//  threedegrees
//
//  Created by Brian Yang on 11/14/15.
//  Copyright © 2015 NickBrian^2. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var currentPercent: UILabel!
    
    var image: UIImage!
    
    // MARK: Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    // hide the keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func sliderChange(sender: UISlider) {
        currentPercent.text = "\(Int(sender.value))"
    }
    
    @IBAction func submit(sender: UIButton) {
        
        print(Int(currentPercent.text!))
        
        if (Int(currentPercent.text!) > 95){
            let alert = UIAlertController(title: "Error", message: "Burn percentage can't be greater than 95%.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
        
        if (Int(currentPercent.text!) < 0) {
            let alert = UIAlertController(title: "Error", message: "Lol what's negative burn anyway?", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
        
        // make a post request to server
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:5555/image")!)
        request.HTTPMethod = "POST"
        request.timeoutInterval = 14
        
        let base64String = UIImagePNGRepresentation(self.image)!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        let postString = "image=\(base64String)&percent=\(currentPercent.text!)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let requestTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response=\(response!)")
            
//            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print("responseString=\(responseString)")
            
        })
        requestTask.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // allow user to find an image on their device
    @IBAction func selectImageAction(sender: UIButton) {
        
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
        
        self.image = selectedImageGallery
        
        // change select image button to say select another
        selectButton.setTitle("Select another image", forState: .Normal)
        
        // only allow submission when an image is selected
        submitButton.enabled = true
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    

}

