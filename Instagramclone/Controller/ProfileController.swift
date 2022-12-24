//
//  ProfileController.swift
//  Instagramclone
//
//  Created by user on 2022/12/05.
//

import UIKit

// 아래 configureCollectionView()사용을 위한 정의
private let cellIdentifier = "ProfileCell"
private let headerIdentifier = "ProfileHeader"

class ProfileController: UICollectionViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        
    }
    
    // MARK: - Helpers
    
    func configureCollectionView() {
        
        collectionView.backgroundColor = .white
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(ProfileHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
}

    // MARK: - UICollectionViewDataSource
    // 데이터 소스를 빠르게 설정하기위한 방법
extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //dequeueReusableCell는 메모리관리를 위해 존재// 10:13까지 들음
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProfileCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        
        return header
    }
}
    

    // MARK: - UICollectionViewDelegate
    // 컬렉션 보기에서 항목을 선택하는 것과 같은 작업
extension ProfileController {
    
}
    // MARK: - UICollectionViewDelegateFlowLayout
    // 컬렉션에 대한 모든 크기를 결정
extension ProfileController : UICollectionViewDelegateFlowLayout {
    //각 셀마다(사진 피드 한개마다 나오는) 간격맞춤 = 1픽셀씩 주었다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    //인스타그램 프로필에 있는 피드들이 한줄에 3개씩 있고 그 사이에 2줄 1픽셀씩 있어 함수를 이렇게 적어주었다)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    //각 셀이 헤더크기를 참고해서 만들어준다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}
