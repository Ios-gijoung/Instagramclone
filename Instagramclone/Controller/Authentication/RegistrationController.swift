//
//  RegistrationController.swift
//  Instagramclone
//
//  Created by user on 2022/12/14.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    //이 속성을 통해 AuthenticationViewModel의 RegistrationViewModel을 사용할 수 있다.
    private var viewModel = RegistrationViewModel()
    
    private let plushPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
        return button
    }()
    
    //Sign up 누를시 나올 텍스트필드와 버튼을 구성해 준다, 모두 작성시 스택뷰로 넘어간다
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
    
    private let fullnameTextField = CustomTextField(placeholder: "Fullname")
    private let usernameTextField = CustomTextField(placeholder: "Username")
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    //  가입 문구 만들기
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        //extension에서 정의한 양식을 붙여넣어준다.
        button.attributedTitle(firstPart: "Don't have an account?", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        //여기서 셀프는 로긴 컨트롤러 클래스를 말한다, 누르면 아래 핸들쇼 사인업이 실행됨, 목적은 터치시(클릭시) 기재내용으로 들어간다.
        //handleShowLogin함수는 아직 없으니 아래 Action부분에 만들어 준다.
        return button
    }()
    
    
    // MARK: - Action
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    //각 텍스트필드에 글씨를 안쓰면 버튼 활성화가 안된다.
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else  if sender == fullnameTextField {
            viewModel.fullname = sender.text
        } else {
            viewModel.username = sender.text
        }
        updateForm()
    }
    
    //위 plusphotobutton을 위해 handleProfilePhotoSelect기능을 만들어준다.
    @objc func handleProfilePhotoSelect() {
       let picker = UIImagePickerController()
        picker.delegate = self //RegistrationController 자신을 받기에 셀프로 만들어 준다. 아래 확장함수도 함께 만들어준다.
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
        
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        configureGradientLayer()
        
        //사진추가 버튼 추가
        view.addSubview(plushPhotoButton)
        plushPhotoButton.centerX(inView: view)
        plushPhotoButton.setDimensions(height: 140, width: 140)
        plushPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullnameTextField, usernameTextField,signUpButton])
        //기재되어있는 텍스트필드에 맞게 수정해 준다.
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: plushPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft:32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func configureNotificationObservers() {
        //configureNotificationObservers = 알림 관찰자 구성
        //lifecycle에 등록 해줘야 한다.
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

// MARK: - FormViewModel
// 액션 부분에 updateForm()을 넣어준다.
extension RegistrationController: FormViewModel {
   func updateForm() {
       //이 문장들 덕분에 양식이 잘되면 활성화하고 잘못됫다면 활성화 하지 않는다.
       signUpButton.backgroundColor = viewModel.buttonBackgroundColor
       signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
       signUpButton.isEnabled = viewModel.formIsValid
   }
}

// MARK: - UIImagePickerControllerDelegate

// 이 확장덕분에 포토플러스 버튼 이용이 가능해진다.
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        
        plushPhotoButton.layer.cornerRadius = plushPhotoButton.frame.width / 2 //프로필 사진 둥굴게
        plushPhotoButton.layer.masksToBounds = true
        plushPhotoButton.layer.borderColor = UIColor.white.cgColor
        plushPhotoButton.layer.borderWidth = 2
        plushPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
