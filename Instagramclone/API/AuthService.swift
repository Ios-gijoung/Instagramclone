//
//  AuthService.swift
//  Instagramclone
//
//  Created by user on 2022/12/21.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileimage: UIImage
}

struct AuthService {
    static func logUserIn(withEmail email: String, password: String, completion:  @escaping(AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        //이메일과 비밀번호로 로그인하지 않고 바로 로그인완료상태로 만든다. 
    }
    
    
    static func registerUser(withCredential credentials: AuthCredentials) {
        print("DEBUG: Credentials are \(credentials)")
    }
}
