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
    let profileImage: UIImage
}

struct AuthService {
    static func logUserIn(withEmail email: String, password: String, completion:  @escaping(AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        //이메일과 비밀번호로 로그인하지 않고 바로 로그인완료상태로 만든다.
        
    }
    static func registerUser(withCredential credentials : AuthCredentials, completion : @escaping(Error?) -> Void) {
        print(#function)
        // 이게 끝나면, imageUrl 에 접근 !
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                
                if let error = error {
                    print("DEBUG : Failed to register user \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                let data : [String : Any] = ["email" : credentials.email,
                                             "fullname" : credentials.fullname,
                                             "profileImageUrl" : imageUrl,
                                             "uid" : uid,
                                             "username" : credentials.username]
                
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
                //               Firestore.firestore().collection("users").document(uid).setData(data, completion : completion)
            }
        }
    }
}
