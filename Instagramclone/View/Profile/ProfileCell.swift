//
//  profileCell.swift
//  Instagramclone
//
//  Created by user on 2022/12/22.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    // MARK: - Properties
    //포스트 이미지 만들어주기 
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "294cbb43a5c4c85e19a59ce589265bf4")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK: - Lifecycle
    // 작성시 required' initializer 'init(coder:)' must be provided by subclass of 'UICollectionViewCell' 오류가 나오는데 이를 통해 코드를 작성해준다. 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        addSubview(postImageView)
        postImageView.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
