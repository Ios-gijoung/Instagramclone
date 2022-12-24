//
//  FeedController.swift
//  Instagramclone
//
//  Created by user on 2022/12/05.
//

import UIKit
import Firebase

// 재사용 식별자를 동일하게 한다음 전달해준다. (reuseIdentifier에대해 공부해보자)
private let reuseIdentifier = "Cell"

class FeedController: UICollectionViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Action
    // 이부분에 로그아웃기능을 만들어서 메인에 있던 로그아웃 함수를 없애야 한다.
    // 파이어베이스 기술부분이므로 파이어베이스를 임폴트 해준다.
    @objc func handleLogout() {
            do {
                try Auth.auth().signOut()
                let controller = LoginController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
                //이코드 덕분에 사용자가 로그아웃하면 해당 로그인페이지가 나타난다. 
            } catch {
                print("DEBUG: Failed to sign out")
            }
        }
    
    // MARK: - Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
        //컬렉션 뷰 셀을 등록
        collectionView.register(FeedCell.self , forCellWithReuseIdentifier: reuseIdentifier)
        //액션 부분에 handleLogout을 추가해줬으니 위에 액션에도 로그아웃 버튼을 만들어줘야 한다.
        //네비게이션바에 Logout과 Feed를 맞춰준다. 
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self , action: #selector(handleLogout))
        navigationItem.title = "Feed"
    }
}
    // MARK: - UICollectionViewDataSource

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 //셀을 몇개나 만들 것인지
    }
    
    
    //셀을 어떤 방식으로 만들 것인지
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //셀을 정의(reuseIdentifier 덕분에 위아래 스크롤시 그림이 나왔다 사라진다[누적 및 대기 프로세스에 도움])
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell 
        return cell
    }
}
    // MARK: - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    // 컬렉션뷰 셀이 올바르게 가져오는 크기가 된다.(sizeForItemAt)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: width, height: height)
    }
}
