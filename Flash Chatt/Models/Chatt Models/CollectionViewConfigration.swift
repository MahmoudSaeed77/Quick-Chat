//
//  CollectionViewConfigration.swift
//  Flash Chatt
//
//  Created by Mohamed Ibrahem on 5/22/19.
//  Copyright © 2019 Mahmoud. All rights reserved.
//

import UIKit
import Firebase

extension ChattTableViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomCellController
        
        cell.messageLabel.text = messageArray[indexPath.row].messegeBody
        cell.nameLabel.text = messageArray[indexPath.row].sender
        
        if cell.nameLabel.text == Auth.auth().currentUser?.email {
            incomming = false
            outgoing = true
            cell.incomming(incomming: incomming)
            
        }else{
            incomming = true
            outgoing = false
            cell.incomming(incomming: incomming)
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let messegeText = messageArray[indexPath.row].messegeBody as String? {
            let size = CGSize(width: view.frame.width, height: 1000000000)
            let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            let esstimateFrame = NSString(string: messegeText).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], context: nil)
            
            return CGSize(width: view.frame.width, height: esstimateFrame.height + 20)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        messageTextField.endEditing(true)
    }
    
    
    
    
    
}
