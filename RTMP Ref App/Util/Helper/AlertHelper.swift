//
//  AlertHelper.swift
//  RTMP Ref App
//
//  Created by Oğulcan on 9.07.2018.
//  Copyright © 2018 AntMedia. All rights reserved.
//

import Foundation
import UIKit

open class AlertHelper: NSObject, UIAlertViewDelegate {
    
    fileprivate static let instance = AlertHelper()
    
    fileprivate var alertView: UIAlertController?
    fileprivate var inputField: UITextField?
    fileprivate var cancelAction: SimpleClosure?
    fileprivate var options = Array<(title: String, action: ((String?) -> Void))>()
    
    open class func getInstance() -> AlertHelper {
        return instance
    }
    
    open func addOption(_ title: String, onSelect: @escaping ((String?) -> Void)) {
        options.append((title: title, action: onSelect))
    }
    
    open func show(_ title: String?, message: String?, cancelButtonText: String = "Cancel", cancelAction: SimpleClosure? = nil) {
        self.cancelAction = cancelAction
        alertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        addButtons(cancelButtonText)
        
        UIApplication.presentView(alertView!)
    }
    
    open func showInput(_ target: UIViewController, title: String?, message: String?, cancelButtonText: String = "Cancel", cancelAction: SimpleClosure? = nil) {
        self.cancelAction = cancelAction
        alertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertView!.addTextField(configurationHandler: {
            (textField: UITextField) -> Void in
            self.inputField = textField
        })
        
        addButtons(cancelButtonText)
        target.present(alertView!, animated: true, completion: nil)
    }
    
    fileprivate func addButtons(_ cancelButtonText: String) {
        alertView!.addAction(UIAlertAction(title: cancelButtonText, style: UIAlertActionStyle.cancel, handler: {
            (_) -> Void in
            self.options.removeAll()
            self.cancelAction?()
        }))
        
        for option in options {
            alertView!.addAction(UIAlertAction(title: option.title, style: UIAlertActionStyle.default, handler: {
                (_) -> Void in
                self.options.removeAll()
                self.alertView = nil
                option.action(self.inputField?.text)
            }))
        }
    }
}
