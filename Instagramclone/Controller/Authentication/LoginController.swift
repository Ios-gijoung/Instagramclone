//
//  LoginController.swift
//  Instagramclone
//
//  Created by user on 2022/12/14.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    //이 속성을 통해 LoginViewModel을 사용할 수 있다.
    private var viewModel = LoginViewModel()
    
    // 아이콘을 만들어 줬다면 아래 Helpers에 등록해주자.
    private let iconImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    // 텍스트 필드 등록 해주고 아래 어느지점에 등록할건지 아래 helpers에 말해주자
    // 뷰의 커스텀 텍스트필드 덕분에 짧게 정리할 수 있다.
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true  // 비밀번호 안전
        return tf
    }()
    
    //로그인 버튼 생성
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        return button
    }()
    
    // 비밀번호 까먹었을때 문구 만들기
    // 코드가 너무 길기 때문에 Extension에 기능을 추가해서 짧게 만들어준다.
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        //extension에서 정의한 양식을 붙여넣어준다.
        button.attributedTitle(firstPart: "Forgot your password ", secondPart: " Get help signing in.")
        return button
    }()
    
    //  가입 문구 만들기
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        //extension에서 정의한 양식을 붙여넣어준다.
        button.attributedTitle(firstPart: "Don't have an account?", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside) //여기서 셀프는 로긴 컨트롤러 클래스를 말한다, 누르면 아래 핸들쇼 사인업이 실행됨, 목적은 터치시(클릭시) 기재내용으로 들어간다.
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: - Actions
    // 이버튼 덕분에 사인업 누르면 리지스트레이션 페이지로 넘어갈 수 있다.
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //로그인창과 비밀번호창 입력한 것들을 알려준다.
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
    
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
        //이 문장들 덕분에 로그인 양식이 잘되면 활성화하고 잘못됫다면 활성화 하지 않는다. 
        
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        configureGradientLayer()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        // 로그인과 패스워드 치는곳 - 로그인 버튼도 추가해주자
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPasswordButton]) //비밀번호 찾기는 로그인 아래있어서 이걸로 해줌
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft:32, paddingRight: 32)
        
        //가입버튼 조정
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    //configureNotificationObservers = 알림 관찰자 구성
    //lifecycle에 등록 해줘야 한다.
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}
