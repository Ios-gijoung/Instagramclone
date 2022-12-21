//
//  ImageUploader.swift
//  Instagramclone
//
//  Created by user on 2022/12/21.
//

import FirebaseStorage
import UIKit

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) { //String을 통해 이미지 URL을 다운로드 한다.(파이어베이스에 있는 프로필파일 주소)
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        //위 함수를 통해 jpegData를 가져오고, 퀄리티 75%만큼 가져온다(압축)
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("DEBUG: Failed to upload image \(error.localizedDescription)") //이 코드 덕분에 사진 불러올때 오류가 생기면 어느 이미지파일이 오류났고 멈춘다.
                return
            }
            //여기까지가 이미지파일 다운받는 프로세스이다, 여길 통과되지 못하면 파일도 가져오지 못한다. 
            ref.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
                
                
            }
        }
    }
}
