//
//  ViewController.swift
//  Flash Chatt
//
//  Created by Mahmoud on 1/24/19.
//  Copyright © 2019 Mahmoud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let firstScreen: UIImageView = {
        let image: UIImage = UIImage(named: "background")!
        let img = UIImageView(image: image)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    
    let theStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .green
//        stack.axis = .vertical
//        stack.spacing = 10
//        stack.distribution = .equalSpacing
        return stack
    }()
    
    let regButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Register", for: .normal)
        btn.backgroundColor = .purple
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 18
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        return btn
    }()
    
    
    let logButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("LogIn", for: .normal)
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 18
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
//        view.addSubview(firstScreen)
        view.addSubview(theStack)
        theStack.addSubview(regButton)
        theStack.addSubview(logButton)
        setupConstraints()
        
        self.title = "Welcome"
        
        logButton.addTarget(self, action: #selector(logAction), for: .touchUpInside)
        regButton.addTarget(self, action: #selector(regAction), for: .touchUpInside)
        
    }
    
    @objc func logAction(sender: UIButton!) {
        print("login button tapped")
        let vc = LogInViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func regAction(sender: UIButton!) {
        print("register button tapped")
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupConstraints() {
//        firstScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        firstScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        firstScreen.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        firstScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        /*theStack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        theStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true*/
        theStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        theStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        theStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        theStack.heightAnchor.constraint(equalToConstant: 83).isActive = true
        
        regButton.leadingAnchor.constraint(equalTo: theStack.leadingAnchor).isActive = true
        regButton.trailingAnchor.constraint(equalTo: theStack.trailingAnchor).isActive = true
        regButton.topAnchor.constraint(equalTo: theStack.topAnchor).isActive = true
        regButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        logButton.leadingAnchor.constraint(equalTo: theStack.leadingAnchor).isActive = true
        logButton.trailingAnchor.constraint(equalTo: theStack.trailingAnchor).isActive = true
        logButton.bottomAnchor.constraint(equalTo: theStack.bottomAnchor).isActive = true
        logButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }


}

