//
//  NewPostVC.swift
//  inkHub
//
//  Created by Kaleb  on 11/16/18.
//  Copyright © 2018 KMTech. All rights reserved.
//

import UIKit

class NewPostVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // can we add placeholder text for textview?
        textView.delegate = self
        textView.text = "Content..."
        textView.textColor = .lightGray
        
        
        // TESTING
        self.textView.layoutManager.allowsNonContiguousLayout = false

        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        // can we change color of done button?
        doneButton.tintColor = UIColor(red:0.94, green:0.42, blue:0.00, alpha:1.0)
        
        toolBar.setItems([doneButton], animated: false)
        
        titleTextField.inputAccessoryView = toolBar
        
        textView.inputAccessoryView = toolBar
        
        
        // listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name:UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name:UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        // stop listening for keyboard hide/show events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification) {

        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        // This is the part where the textview should scroll
        // to where the cursor is
        if notification.name == UIResponder.keyboardDidShowNotification {
            let mainViewY = self.view.frame.origin.y
            let textViewY = self.textView.frame.origin.y
            let oneLineHeight = self.textView.font?.lineHeight
            let delta = (textViewY - mainViewY) - oneLineHeight!
            let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            let keyboardHeight = (keyboardSize?.height)!
            self.textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + delta, right: 0)
            self.textView.scrollIndicatorInsets = textView.contentInset
            
        } else if notification.name == UIResponder.keyboardWillShowNotification ||
            notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardRect.height
            
        } else if notification.name == UIResponder.keyboardWillHideNotification {
            // if keyboard will hide
            view.frame.origin.y = 0
            
            self.textView.contentInset = UIEdgeInsets.zero
            self.textView.scrollIndicatorInsets = UIEdgeInsets.zero
        }
        
        
    }
    
    
    // * * * * * WE WANT PLACEHOLDER TEXT FOR TEXTVIEW * * * * *
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Content..." && textView.textColor == .lightGray)
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }
    // TESTING
    func textViewDidChange(_ leTextView: UITextView) {
        // TESTING
        print("Text View Did Change")
        let bottom = NSMakeRange(textView.text.count - 1, 1)
        textView.scrollRangeToVisible(bottom)

    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "")
        {
            textView.text = "Content..."
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
    // * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
    
    
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
