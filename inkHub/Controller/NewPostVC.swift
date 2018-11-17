//
//  NewPostVC.swift
//  inkHub
//
//  Created by Kaleb  on 11/16/18.
//  Copyright © 2018 KMTech. All rights reserved.
//

import UIKit

class NewPostVC: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([doneButton], animated: false)
        
        titleTextField.inputAccessoryView = toolBar
        
        textView.inputAccessoryView = toolBar
        
        
        // listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name:UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        // stop listening for keyboard hide/show events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification) {

        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification ||
            notification.name == UIResponder.keyboardWillChangeFrameNotification {
            
            view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
        }
        
        
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }

    @IBAction func cancelPressed(_ sender: UIButton) {
        // close keyboard then screen
        self.view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postPressed(_ sender: UIButton) {
        // TODO: ADD POST !!
        
        // if title and content are not empty,
        // then exit
        if titleTextField.text != "" && textView.text != "" {
            // close keyboard then screen
            self.view.endEditing(true)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    // This method will hide the keyboard when touch is outside the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
