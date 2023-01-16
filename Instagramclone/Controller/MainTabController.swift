//
//  MainController.swift
//  Instagramclone
//
//  Created by user on 2022/12/05.
//
// 아래쪽 탭컨트롤러 (5개 아이콘)
import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    private var user: User? {
        didSet {
            guard let user = user else { return }
            configureViewControllers(withUser: user)
        }
    }
    
    // MARK: - Lifecycle
     override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        fetchUser()
    }
    
    // MARK: - API
    
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
        }
    }

    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            // 현재 사용자가 로그인 되어있는지 확인시켜주는 API와 관련있다.(currentUser가)
            // 로그인이 안되어 있다면 로그인 컨트롤러를 다시 띄어준다. 
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self  //컨트롤러 델리게이트를 만족시켜야 한다.
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }    
    // MARK: - Helpers
    // 메인컨트롤러에 어떤걸 표시할건지 여기에 정리해준다
    func configureViewControllers(withUser user: User) {
        view.backgroundColor = .white
        
       
        let layout = UICollectionViewFlowLayout()
        //네비겡이션바에 각기능을 추가
        let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController(collectionViewLayout: layout))
        
        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController())
        
        let imageSelector = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorController())
        
        let notifications = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationsController())
        
        
        let profileController = ProfileController(user: user)
        let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"),
                                                   rootViewController: profileController) //컬렉션뷰로 시작하기때문에 루트뷰, 프로파일컨트롤러는 컬렉션뷰 레이아웃이 된다
        
        viewControllers = [feed, search, imageSelector, notifications, profile]
        
        tabBar.tintColor = .black
        
    }
    //위 let 상수들의 옵션을 만들어 주기 위해 조건식을 만들어 주었다.
    func templateNavigationController(unselectedImage : UIImage, selectedImage : UIImage, rootViewController : UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        return nav
    }
}

    // MARK: - AuthenticationDelegate 
extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {
        fetchUser()
        self.dismiss(animated: true, completion: nil ) //사용자 인증기능 수행, 여기서 셀프는 MainTabController을 말한다. 
    }
}
