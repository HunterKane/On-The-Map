//
//  Textfields.swift
//  On The Map
//
//  Created by Hunter Sparrow on 4/18/18.
//  Copyright © 2018 Hunter Sparrow. All rights reserved.
//

import UIKit


extension UIViewController: UITextFieldDelegate {
    
    
    public struct keyboardYLimit {
        static var buttonY: CGFloat = 0.0
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func getViewYShift(notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height - 88.0
    }

    
    @objc func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y = -getViewYShift(notification: notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func subscribeToKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name:.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        
    }
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    public func resignIfFirstResponder(_ textField: UITextField) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
    
    
    
    
    
    
    
}
