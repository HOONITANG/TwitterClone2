//
//  MainTabController.swift
//  TwitterClone2
//
//  Created by Taehoon Kim on 2021/12/26.
//

import UIKit

class MainTabController: UITabBarController {
    
    var user:User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed =  nav.viewControllers.first as? FeedController else { return }
            feed.user = user
        }
    }
    
    // MARK: - Properties
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureUI()
        fetchUser()
    }
    
    func fetchUser() {
        user = User(dictionary: [:])
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .red
        
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }
    
    
    func configureViewController() {
        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav1 = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feed)
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: explore)
        
        viewControllers = [nav1, nav2]
        
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
    // MARK: - Selector
    @objc func actionButtonTapped() {
    
        guard let user = user else { return }
        let controller = UploadTweetController(user: user)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true, completion: nil)
    }
}
