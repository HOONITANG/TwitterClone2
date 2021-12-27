//
//  UploadTweetController.swift
//  TwitterClone2
//
//  Created by Taehoon Kim on 2021/12/26.
//

import UIKit
import Firebase


class UploadTweetController: UIViewController {
    
    
    //MARK: - Property
    var user:User?
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .twitterBlue
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("Tweet", for: .normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32 / 2
        
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        return iv
    }()
    
    
    private let captionTextView = CaptionTextView()
    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        NotificationCenter.default.addObserver(captionTextView.self, selector: #selector(self.handleTextInputChange(_:)), name: UITextView.textDidChangeNotification, object: nil)
        configureUI()
        
    }
    
    //MARK: - helpers
    func configureUI() {
        view.backgroundColor = .white
        
        configureNaivgationBar()
        
        
        
        view.addSubview(profileImageView)
        profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        view.addSubview(captionTextView)
        captionTextView.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)        
    }
    
    func configureNaivgationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handelCancel))
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
    
    //MARK: - Selector
    @objc func handelCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUploadTweet() {
        guard let caption = captionTextView.text else { return }
        let DB_REF = Database.database().reference()
        let REF_TWEETS = DB_REF.child("tweets")
        
        let values = [
            "timestamp": Int(NSDate().timeIntervalSince1970),
            "likes": 0,
            "retweets": 0,
            "caption": caption ] as [String: Any]
        REF_TWEETS.updateChildValues(values) { (err, ref) in
            print("DEBUG:: update tweet value is \(ref)")
        }
    }
}
