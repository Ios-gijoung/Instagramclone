//
//  SearchController.swift
//  Instagramclone
//
//  Created by user on 2022/12/05.
//

import UIKit

private let reuseIdentifier = "UserCell" //재사용 셀은 유저셀이라고 한다.

class SearchController: UITableViewController {
    
    
    // MARK:    - Properties
    
    private var users = [User]()
    private var filteredUsers = [User]() //필터링되는 유저들을 위해 만듬
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty //비어있을때는 기본 검색창을 보여주고 싶고, 검색하는 순간 필터링 기술을 계속해서 쓰고싶을때 쓴다.
    }
    
    // MARK:    - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureTableView()
        fetchUsers()
    }
    
    // MARK:    - API
    
    func fetchUsers() {
        UserService.fetchUsers { users in
            self.users = users
            self.tableView.reloadData() //이 문장을 통해 테이블뷰 데이터를 가져온다.
        }
    }
    
    // MARK:    - Helpers
    
    func configureTableView() {
        view.backgroundColor = .white
        
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self // 검색 결과가  업데이트 되거나 같다고 말하는 것
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search" //서치전 회색글자로 표시해두기
        navigationItem.searchController =  searchController
        definesPresentationContext = false
    
    }
}

// MARK:    - UITableViewDataSource

extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filteredUsers.count : users.count // 필터모드를 사용하라는 메세지, 삼항연산, 여기 조건들이 모두 참이면 사용자의 계정을 반환 
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        //여기에대한 식별자를 맨위에 Private 함수로 만들어 준다.
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row] //검색모드와 필터링모드 설정 
        cell.viewModel = UserCellViewModel(user: user)
        return cell
        //cell.viewModel = users[indexPath.row] //테이블뷰의 올바른 정보를 가져오게 해주는 역할, 각 행렬에 맞게 유저를 불러온다 [indexPath.row]덕분에
    }
}


// MARK:    - UITableViewDelegate

//이 함수를 만들어서 검색 후 프로필을 누를때마다 디버그에서 메세지가 표시된다.
extension SearchController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row] //검색모드와 필터링모드 설정
        let controller = ProfileController(user: user) //우리가 사용자를 전달해야 하는 이 사용자 지정 종속성 주입을 만들었다는걸 안다.
        navigationController?.pushViewController(controller, animated: true) //이 문장 덕분에 검색 후 나오는 사람의 프로필에 들어갈 수 있다.
    }
}

// MARK:    - UISearchResultsUpdating

extension SearchController:  UISearchResultsUpdating { //UISearchResultsUpdating치면 아래 업데이트 리졸트 양식이 저절로 나온다.
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return } //첫글자를 소문자로 해준다.
        filteredUsers = users.filter({
            $0.username.contains(searchText) || // ||는 or라는 뜻을 가지고 있다.
            $0.fullname.lowercased().contains(searchText)   // $0은 몇번째에 있는지 알려주는 함수이다. * 노션 참고
        })
        self.tableView.reloadData()
    }
}

//22:23분 까지 들음
