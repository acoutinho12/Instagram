//
//  HomeViewController.swift
//  Instagram
//
//  Created by Andre Luis Barbosa Coutinho on 30/05/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let addStoriesButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: nil)
    private let notificationsButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: nil)
    private let messagesButton = UIBarButtonItem(image: UIImage(systemName: "paperplane"), style: .plain, target: self, action: nil)
    private let navigationItemTitle = UILabel()
    private var tableView = UITableView();
    
    private var posts: [Post] = [];
    private static let feedCell = "FeedViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad();
        posts = fetchData();
        configureNavigationItem()
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        isLoggedIn();
    }
    
    private func configureNavigationItem(){
        addStoriesButton.tintColor = .label
        notificationsButton.tintColor = .label
        messagesButton.tintColor = .label
        
        navigationItemTitle.text = "UICloneGram"
        navigationItemTitle.textAlignment = .left
        navigationItemTitle.translatesAutoresizingMaskIntoConstraints = false;
        
        self.navigationItem.titleView = navigationItemTitle;
        self.navigationItem.rightBarButtonItems = [messagesButton,notificationsButton,addStoriesButton];
    }
    
    private func configureTableView(){
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.register(FeedViewCell.self, forCellReuseIdentifier: HomeViewController.feedCell)
        tableView.pin(to: view);
        tableView.rowHeight = view.height*0.7
        tableView.showsVerticalScrollIndicator = false;
        tableView.allowsSelection = false;
    }
    
    private func setTableViewDelegates(){
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    
    private func isLoggedIn() {
        let userIsLoggedIn = UserDefaults.standard.bool(forKey: "userIsLoggedIn")
        if !userIsLoggedIn {
            let loginVC = LoginViewController();
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC,animated: false);
        }
    }
    
}

extension HomeViewController {
    
    func fetchData() -> [Post] {
        let description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
        
        let user1 = User(userImage: UIImage(systemName: "person")!, userNickName: "John_Savior")
        let user2 = User(userImage: UIImage(systemName: "person.crop.circle")!, userNickName: "Michel_Benny")
        let user3 = User(userImage: UIImage(systemName: "person.fill")!, userNickName: "Noe_Doe")
        let user4 = User(userImage: UIImage(systemName: "person.circle.fill")!, userNickName: "Derek_Smith")
        let user5 = User(userImage: UIImage(systemName: "person.circle")!, userNickName: "TheBeachs")
        
        let post1 = Post(user: user1, post: Images.cat, liked: Bool.random(), savedPost: Bool.random(), comments: nil, userComment: "So cute",description: description)
        let post2 = Post(user: user2, post: Images.build, liked: Bool.random(), savedPost: Bool.random(), comments: nil, userComment: nil,description: description)
        let post3 = Post(user: user3, post: Images.flower, liked: Bool.random(), savedPost: Bool.random(), comments: nil, userComment: nil,description: description)
        let post4 = Post(user: user4, post: Images.trees, liked: Bool.random(), savedPost: Bool.random(), comments: nil, userComment: nil,description: description)
        let post5 = Post(user: user5, post: Images.wave, liked: Bool.random(), savedPost: Bool.random(), comments: nil, userComment: nil,description: description)
        
        return [post1,post2,post3,post4,post5]
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.feedCell) as! FeedViewCell;
        let post = posts[indexPath.row]
        cell.set(post: post)
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
}
