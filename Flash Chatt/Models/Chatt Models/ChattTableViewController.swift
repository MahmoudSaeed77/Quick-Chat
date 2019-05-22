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
    
    //MARK:- our sweet variables
    
    let cellId = "cellId"
    var messageArray: [Message] = [Message]()
    var bottomConstraint: NSLayoutConstraint?
    var incomming: Bool!
    var outgoing: Bool!
    
    //MARK:- declare design items
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
    
    //MARK:- view did load
    
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
    //MARK:- constraints method
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
    
    //MARK:- keyboard methods
    func keyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    
    //MARK:- setup view methods
    func addedViews(){
        view.addSubview(collectionView)
        view.addSubview(messagingView)
        messagingView.addSubview(messageTextField)
        messagingView.addSubview(sendButton)
    }
    
    func setupDelegate(){
        collectionView.delegate = self
        collectionView.dataSource = self
        messageTextField.delegate = self
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
    
    //MARK:- Action methods
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
    //MARK:- Retrieve Data method
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





