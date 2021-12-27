//
//  FeedController.swift
//  TwitterClone2
//
//  Created by Taehoon Kim on 2021/12/26.
//

import UIKit
import Firebase

private let reuseIdentifier = "TweetCell"
let DB_REF = Database.database().reference()

class FeedController: UICollectionViewController {
    
    // MARK: - Properties
    var user: User? {
        didSet {
            print("Debug:: usernamse is \(user?.fullname)")
        }
    }
 
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLeftBarButton()
    }
    
    // MARK: - Helpers
    func configureUI() {
        collectionView.backgroundColor = .white
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        
        navigationItem.titleView = imageView
    }
    
    func fetchTweet() {
        
    }
    
    func configureLeftBarButton() {
        let profileImageView = UIImageView()
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.backgroundColor = .black
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}

// MARK: - UICollectionViewDelegate/DataSource
extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}
