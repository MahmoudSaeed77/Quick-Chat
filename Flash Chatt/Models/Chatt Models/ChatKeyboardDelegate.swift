//
//  ChatKeyboardDelegate.swift
//  Flash Chatt
//
//  Created by Mohamed Ibrahem on 5/22/19.
//  Copyright © 2019 Mahmoud. All rights reserved.
//

import UIKit

extension ChattTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.messageTextField.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.messageTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
}
