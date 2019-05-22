//
//  CustomCellController.swift
//  Flash Chatt
//
//  Created by Mahmoud on 2/2/19.
//  Copyright © 2019 Mahmoud. All rights reserved.
//

import UIKit

class CustomCellController: UICollectionViewCell{
    
    
    private var incommingConstraints: [NSLayoutConstraint]!
    private var outgoingConstraints: [NSLayoutConstraint]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(avatarImage)
        addSubview(containerView)
//        containerView.addSubview(avatarImage)
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        sentMessegeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    
    let avatarImage: UIImageView = {
        let image: UIImage = UIImage(named: "doda")!
        let img = UIImageView(image: image)
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 10
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Mahmoud Saeed"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let messageLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Hi There my  name is mahmoud"
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let containerView: UIView = {
        let theView = UIView()
        theView.translatesAutoresizingMaskIntoConstraints = false
//        theView.backgroundColor = .gray
        theView.layer.masksToBounds = true
        theView.layer.cornerRadius = 10
        return theView
    }()
    
    func sentMessegeConstraints() {
        
        
        
        
        incommingConstraints = [
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            containerView.widthAnchor.constraint(lessThanOrEqualToConstant: 350),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            avatarImage.widthAnchor.constraint(equalToConstant: 30),
            avatarImage.heightAnchor.constraint(equalToConstant: 30),
            
//            avatarImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            avatarImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 15),
            
            messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
            
            
            
            
            
        ]
        
        outgoingConstraints = [

            
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerView.widthAnchor.constraint(lessThanOrEqualToConstant: 320),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            avatarImage.widthAnchor.constraint(equalToConstant: 10),
            avatarImage.heightAnchor.constraint(equalToConstant: 10),
//            avatarImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            avatarImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            avatarImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: avatarImage.leadingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 15),
            
            messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
            
            
            
            
            
            
            ]
    }
    
    func incomming(incomming: Bool)  {
//        let insestIncomming = UIEdgeInsets(top: 17, left: 26.5, bottom: 17.5, right: 21)
//        let insestOutcomming = UIEdgeInsets(top: 17, left: 21, bottom: 17.5, right: 26.5)
        if incomming {
//            let image = UIImage(named: "MessageBubble")
//            let flippedImage = UIImage(cgImage: (image?.cgImage)!, scale: (image?.scale)!, orientation: UIImage.Orientation.upMirrored).resizableImage(withCapInsets: insestIncomming)
//            avatarImage.image = flippedImage

            NSLayoutConstraint.deactivate(outgoingConstraints)
            NSLayoutConstraint.activate(incommingConstraints)
            containerView.backgroundColor = .gray
            nameLabel.textColor = .gray
            messageLabel.textColor = .white
            avatarImage.layer.masksToBounds = true
            avatarImage.layer.cornerRadius = 15

        }else{


            NSLayoutConstraint.deactivate(incommingConstraints)
            NSLayoutConstraint.activate(outgoingConstraints)
            
            containerView.backgroundColor = .cyan
            nameLabel.textColor = .cyan
            messageLabel.textColor = .black
            avatarImage.layer.masksToBounds = true
            avatarImage.layer.cornerRadius = 5

//            avatarImage.image = UIImage(named: "MessageBubble")?.resizableImage(withCapInsets: insestOutcomming)
        }
    }
    
}
