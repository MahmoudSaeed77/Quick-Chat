//
//  RegisterViewController.swift
//  Flash Chatt
//
//  Created by Mahmoud on 1/29/19.
//  Copyright © 2019 Mahmoud. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate {

    let background: UIImageView = {
        let image: UIImage = UIImage(named: "background1")!
        let img = UIImageView(image: image)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let topView: UIView = {
       let theView = UIView()
        theView.translatesAutoresizingMaskIntoConstraints = false
        return theView
    }()
    
    let emailTextField: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Email"
        txt.backgroundColor = .white
        txt.borderStyle = .roundedRect
        txt.textContentType = UITextContentType.emailAddress
        txt.autocapitalizationType = .none
        return txt
    }()
    
    let passwordTextField: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Password"
        txt.backgroundColor = .white
        txt.borderStyle = .roundedRect
        txt.textContentType = UITextContentType.password
        txt.isSecureTextEntry = true
        txt.autocapitalizationType = .none
        return txt
    }()
    
    let regButTon: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Register", for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        return btn
    }()
    
    let theStack: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let goChatt: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.setTitle("Go Chatt", for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        self.title = "Register"
        
//        view.addSubview(background)
        view.addSubview(topView)
        view.addSubview(goChatt)
        topView.addSubview(theStack)
        theStack.addSubview(emailTextField)
        theStack.addSubview(passwordTextField)
        theStack.addSubview(regButTon)
        
        
        goChatt.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        regButTon.addTarget(self, action: #selector(regTapped), for: .touchUpInside)
        
        
//        background.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        background.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        theStack.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 30).isActive = true
        theStack.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -30).isActive = true
        theStack.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        theStack.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        
        emailTextField.topAnchor.constraint(equalTo: theStack.topAnchor).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: theStack.leadingAnchor).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: theStack.trailingAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        passwordTextField.centerYAnchor.constraint(equalTo: theStack.centerYAnchor).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: theStack.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: theStack.trailingAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        regButTon.bottomAnchor.constraint(equalTo: theStack.bottomAnchor).isActive = true
        regButTon.leadingAnchor.constraint(equalTo: theStack.leadingAnchor).isActive = true
        regButTon.trailingAnchor.constraint(equalTo: theStack.trailingAnchor).isActive = true
        regButTon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        goChatt.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        goChatt.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        goChatt.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
    }
    
    @objc func btnAction(sender: UIButton!) {
        print("go chatt button tapped")
        let vc = ChattTableViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func regTapped(sender: UIButton!) {
        print("reg button tapped")
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error as Any)
            }else{
                print("register successfull!")
                let vc = ChattTableViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        return false
    }
    
}