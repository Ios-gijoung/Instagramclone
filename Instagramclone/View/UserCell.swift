//
//  UserCell.swift
//  Instagramclone
//
//  Created by user on 2023/01/17.
//

import UIKit

class UserCell: UITableViewCell {
    
    // MARK:    - Properties
    
    var user: User? {
        didSet {
            usernameLabel.text = user?.username //이 문장 덕분에 프로필 유저네임과 풀네임을 올바르게 가져올 수 있다. 
            fullnameLabel.text = user?.fullname
        }
    }
    
    // 프로필을 만들어보자
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.image = #imageLiteral(resourceName: "7f103ce7712547aa5fea02546456fd72")
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "MKT_Loui"
        return label
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Eddie Brock"
        label.textColor = .lightGray
        return label
    }() //다 만들어 준다음에 라이프사이클에 등록해준다.
    
    // MARK:    - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.setDimensions(height: 48, width: 48)
        profileImageView.layer.cornerRadius = 48 / 2
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel]) //프로필 네임라벨과 풀네임에 대한 스택을 설정해준다(axis, spacing, alignment)
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
