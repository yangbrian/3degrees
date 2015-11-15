//
//  TableViewController.swift
//  threedegrees
//
//  Created by Brian Yang on 11/15/15.
//  Copyright © 2015 NickBrian^2. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var chart: UIImageView!
    
    // MARK: Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
//        view.addGestureRecognizer(tap)
        
        
    }
    
    // hide the keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}


