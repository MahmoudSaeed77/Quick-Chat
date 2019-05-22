//
//  ChattTableViewController.swift
//  Flash Chatt
//
//  Created by Mahmoud on 1/31/19.
//  Copyright © 2019 Mahmoud. All rights reserved.
//

import UIKit
import Firebase

class ChattTableViewController: UIViewController {
    
    let cellId = "cellId"
    var messageArray: [Message] = [Message]()
    
    var bottomConstraint: NSLayoutConstraint?
    
    
    
    var incomming: Bool!
    var outgoing: Bool!
    
    
    let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collection: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collection.backgroundColor = .white
        collection.isScrollEnabled = true
        collection.alwaysBounceVertical = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let messagingView: UIView = {
        let vi = UIView()
        vi.translatesAutoresizingMaskIntoConstraints = false
        vi.backgroundColor = .white
        return vi
    }()
    
    let messageTextField: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Type here..."
        return txt
    }()
    
    let sendButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Send", for: UIControl.State.normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScrollToBottom()
        setupDelegate()
        keyboardNotification()
        addedViews()
        setupTargets()
        registerClasses()
        setupConstraints()
        retrieveData()
        
        
        
    }
    func ScrollToBottom() {
        let lastSection = self.collectionView.numberOfSections - 1
        let lastRow = self.collectionView.numberOfItems(inSection: lastSection)
        let indexPath = IndexPath(row: lastRow - 1, section: lastSection)
//        let indexPath = IndexPath(item: lastRow, section: lastSection)
        self.collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.bottom, animated: true)
        
        
        

    }
    
    func registerClasses(){
        collectionView.register(CustomCellController.self, forCellWithReuseIdentifier: cellId)
    }
    
    func setupTargets(){
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    func addedViews(){
        view.addSubview(collectionView)
        view.addSubview(messagingView)
        messagingView.addSubview(messageTextField)
        messagingView.addSubview(sendButton)
    }
    
    func keyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func setupDelegate(){
        collectionView.delegate = self
        collectionView.dataSource = self
        messageTextField.delegate = self
    }
    
    @objc func sendButtonTapped(sender: UIButton){
        
        let messageDB = Database.database().reference().child("Messages")
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email,
                                 "MessageBody": messageTextField.text!]
        
        
        messageDB.childByAutoId().setValue(messageDictionary) {
            (error, refernce) in
            if error != nil {
                print(error!)
            }else
            {
                print("message saved succesfully")
                self.messageTextField.text = ""
            }
        }
        
        messageTextField.resignFirstResponder()
        
        
    }
    
    func retrieveData(){
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
            let messege = Message()
            messege.messegeBody = text
            messege.sender = sender
            
            self.messageArray.append(messege)
            self.collectionView.reloadData()
        }
    }

}

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
    
    
    
    
    func setupConstraints(){
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: messagingView.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        messagingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        messagingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        messagingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        messagingView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        messageTextField.leadingAnchor.constraint(equalTo: messagingView.leadingAnchor).isActive = true
        messageTextField.topAnchor.constraint(equalTo: messagingView.topAnchor).isActive = true
        messageTextField.bottomAnchor.constraint(equalTo: messagingView.bottomAnchor).isActive = true
        messageTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        
        sendButton.topAnchor.constraint(equalTo: messagingView.topAnchor).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: messagingView.bottomAnchor).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: messagingView.trailingAnchor).isActive = true
        sendButton.leadingAnchor.constraint(equalTo: messageTextField.trailingAnchor).isActive = true
        
        bottomConstraint = NSLayoutConstraint(item: messagingView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        
    }
    
    
    
    
    @objc func KeyboardWillShow(notification: NSNotification){
        
        if let userInfo = notification.userInfo {
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillHideNotification
            
            bottomConstraint?.constant = isKeyboardShowing ? 0 : (-keyboardSize!.height)
            
            UIView.animate(withDuration: 0) {
                self.view.layoutIfNeeded()
            }
            
        }
        
    }
}

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
