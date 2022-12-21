//
//  AuthenticationViewModel.swift
//  Instagramclone
//
//  Created by user on 2022/12/20.
//

import UIKit

//FormViewModel을 사용하려면 updateForm을 사용해야 한다.
protocol FormViewModel {
    func updateForm()
}

//프로토콜로인해 아래조건들을 모두 충족시켜줘야 한다.
protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
        //이메일이나 비밀번호가 비어있으면 틀리다 (오류가 난다)
    }
    
    var buttonBackgroundColor: UIColor {
        //삼항 연산자 - 보라색, 콜론 다음에는 실패시 나오는 색이다
        return formIsValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}

struct RegistrationViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
        && fullname?.isEmpty == false && username?.isEmpty == false
    }
    //이메일과 패스워드, 풀네임, 유저네임 비어있는 곳이 없어야 한다.
    var buttonBackgroundColor: UIColor {
        return formIsValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}
