//
//  File.swift
//  Instagramclone
//
//  Created by user on 2022/12/25.
//

import Foundation

struct User {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let username: String
    let uid: String
    
    
    //이부분들이 있어서 Userservice에서 하나하나 정보를 입력 안해도 된다.
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? "" // ?? ""은 아무것도 작성하지 않았을때 기본값을 정해주는 것이다.
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
