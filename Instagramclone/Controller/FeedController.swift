//
//  FeedController.swift
//  Instagramclone
//
//  Created by user on 2022/12/05.
//

import UIKit

// 재사용 식별자를 동일하게 한다음 전달해준다. (reuseIdentifier에대해 공부해보자)
private let reuseIdentifier = "Cell"

class FeedController: UICollectionViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
        //컬렉션 뷰 셀을 등록
        collectionView.register(FeedCell.self , forCellWithReuseIdentifier: reuseIdentifier)
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
