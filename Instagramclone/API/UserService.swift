//
//  UserService.swift
//  Instagramclone
//
//  Created by user on 2022/12/24.
//

import Firebase

//유저의 정보를 정의시켜서 한번에 내보낼 수 있게 하는 것이다.
struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void) {  //모든 함수가 완료되면 이스케이핑 함수를 통해 유저를 탈출시킨다,,?
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument {snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
            
        }
    }
}
