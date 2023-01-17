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
    
    // MARK:    - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
}

// MARK:    - UITableViewDataSource

extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        //여기에대한 식별자를 맨위에 Private 함수로 만들어 준다.
        cell.user = users[indexPath.row] //테이블뷰의 올바른 정보를 가져오게 해주는 역할, 각 행렬에 맞게 유저를 불러온다 [indexPath.row]덕분에 
        return cell
    }
}
