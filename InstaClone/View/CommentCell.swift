//
//  CommentCell.swift
//  InstaClone
//
//  Created by mitsuyoshi matsuo on 2019/04/30.
//  Copyright © 2019 mitsuyoshi matsuo. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 12)
//        label.numberOfLines = 0
        
        let attributedText = NSMutableAttributedString(string: "joker", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
        attributedText.append(NSAttributedString(string: " Some test comment", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]))
        attributedText.append(NSAttributedString(string: " 2d.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        label.attributedText = attributedText
        
        return label
    }()

    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 48, height: 48)
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.layer.cornerRadius = 48 / 2
        
        addSubview(commentLabel)
        commentLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // MARK: - Handlers


    
    
    
    
    
    
    // MARK: -

    
    
}
