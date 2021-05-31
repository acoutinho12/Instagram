//
//  FeedViewCell.swift
//  Instagram
//
//  Created by Andre Luis Barbosa Coutinho on 31/05/21.
//

import UIKit

enum fontWeigth: Int {

    case bold = 0, normal = 1

    init(rawValue: Int) {
        switch rawValue {
        case 0: self = .bold
        case 1: self = .normal
        default: self = .normal
        }
    }
}

class FeedViewCell: UITableViewCell {
    
    private let ownerImage: UIImageView = {
        let image = UIImageView();
        return image;
    }()
    
    private let ownerName: UILabel = {
        let name = UILabel();
        name.tintColor = .label
        return name;
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton();
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .label
        return button;
    }()
    
    private let imagePost: UIImageView = {
        let image = UIImageView();
        image.layer.borderWidth = 1.0
        image.layer.borderColor = UIColor.quaternaryLabel.cgColor
        return image;
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton();
        return button;
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton();
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = .label
        return button;
    }()
    
    private let sharePostButton: UIButton = {
        let button = UIButton();
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.tintColor = .label
        return button;
    }()
    
    private let savePostButton: UIButton = {
        let button = UIButton();
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .label
        return button;
    }()
    
    private let likedBy: UILabel = {
        let name = UILabel();
        name.tintColor = .label
        return name;
    }()
    
    private let descriptionPost: UILabel = {
        let name = UILabel();
        name.tintColor = .secondaryLabel
        return name;
    }()
    
    private let allComments: UILabel = {
        let name = UILabel();
        name.tintColor = .systemGray
       
        return name;
    }()
    
    private let seeAllComments: UILabel = {
        let name = UILabel();
        name.tintColor = .systemGray5
        name.font = UIFont.systemFont(ofSize: 14)
        name.layer.opacity = 0.7
        return name;
    }()
    
    func set(post: Post){
        ownerImage.image = post.user.userImage;
        ownerName.text = post.user.userNickName
        imagePost.image = post.post
        if post.liked{
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .red
        }
        else{
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .label
        }
        if post.savedPost{
            savePostButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }
        else{
            savePostButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        
        seeAllComments.text = "See al the \(Int.random(in: 0..<6000)) comments"

        let likedByAttributedString = customLabelStyle(of: ["Liked by", "\(post.liked ? " you" : "user001")", " and", " \(Int.random(in: 0..<6000)) other people"], wichAttr: [.normal,.bold,.normal,.bold])
        likedBy.attributedText = likedByAttributedString;
        
        let descriptionPostAttributedString = customLabelStyle(of: [post.user.userNickName, " \(post.description)"], wichAttr: [.bold,.normal])
        
        descriptionPost.attributedText = descriptionPostAttributedString;
    }
    
    private func customLabelStyle(of label: [String], wichAttr: [fontWeigth]) -> NSMutableAttributedString{
        
        
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.label]
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.label]
        
        let attrs = [attrs1,attrs2];
        
        let attributedString1:NSMutableAttributedString = NSMutableAttributedString(string:label[0], attributes:attrs[wichAttr[0].rawValue]);
        
        for index in 1..<label.count{
            
            let attributedString2 = NSMutableAttributedString(string:"\(label[index])", attributes:attrs[wichAttr[index].rawValue])
            
            attributedString1.append(attributedString2)
        }
        
        return attributedString1;
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(ownerImage)
        contentView.addSubview(ownerName)
        contentView.addSubview(moreButton)
        contentView.addSubview(imagePost)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(sharePostButton)
        contentView.addSubview(savePostButton)
        contentView.addSubview(likedBy)
        contentView.addSubview(allComments)
        contentView.addSubview(descriptionPost)
        contentView.addSubview(seeAllComments)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonSize: CGFloat = contentView.height/15;
        let width: CGFloat = contentView.width;
        let height: CGFloat = contentView.height*0.6;
        let right: CGFloat = contentView.right*0.9;
        
        ownerImage.frame = CGRect(x:8,y:8,width:buttonSize ,height:buttonSize)
        ownerName.frame = CGRect(x:ownerImage.right + 8,y:8,width:width/3 ,height:buttonSize)
        imagePost.frame = CGRect(x:0,y:ownerImage.bottom + 8,width:width ,height:height);
        moreButton.frame = CGRect(x: right, y:8,width:buttonSize ,height:buttonSize)
        
        let buttons = [likeButton, commentButton, sharePostButton];
        
        for index in 0..<buttons.count {
            let button = buttons[index];
            let x: CGFloat = index == 0 ? 8.0 : buttons[index-1].right + 16
            button.frame = CGRect(x: x, y: imagePost.bottom + 8, width: buttonSize, height: buttonSize)
        }
        savePostButton.frame = CGRect(x: right, y: imagePost.bottom + 8, width: buttonSize, height: buttonSize)
        likedBy.frame = CGRect(x: 8, y: likeButton.bottom + 8, width: width, height: buttonSize*0.5)
        descriptionPost.frame = CGRect(x: 8, y: likedBy.bottom + 8, width: width*0.8, height: buttonSize*0.5)
        seeAllComments.frame = CGRect(x: 8, y: descriptionPost.bottom + 8, width: width, height: buttonSize*0.5)
        
    }
}
