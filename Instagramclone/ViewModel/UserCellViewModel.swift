//
//  UserCellViewModel.swift
//  Instagramclone
//
//  Created by user on 2023/01/17.
//

import Foundation

//아래 함수 덕분에 데이터 추출이 쉬워진다.
struct UserCellViewModel {
    private let user: User

    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var username: String {
        return user.username
    }
    
    var fullname: String {
        return user.fullname
    }
    
    init(user: User) {
        self.user = user
    }
}
