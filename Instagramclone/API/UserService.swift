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
    
    static func fetchUsers(completion: @escaping([User]) -> Void) { // 필요한 데이터를 가져오고 각 항목을 사용자 개체에 매핑한 다음 모든 항목을 배치한다. 
        COLLECTION_USERS.getDocuments {(snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            let users = snapshot.documents.map({ User(dictionary: $0.data()) }) //$0은 해당 문세 배열의 각 문서를 나타낸다. 
            completion(users)
        }
    }
}

