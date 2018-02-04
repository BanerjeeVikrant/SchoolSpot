//
//  NavigationViewController.swift
//  bruincave
//
//  Created by user128030 on 7/21/17.
//  Copyright © 2017 user128030. All rights reserved.
//

import UIKit

class NavigationViewController: UIViewController {
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var anonymousView: UIView!
    @IBOutlet weak var notificationsView: UIView!
    @IBOutlet weak var messagesView: UIView!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var feedbackView: UIView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var schoolLabel: UILabel!
    
    var homeTapGesture = UITapGestureRecognizer()
    var anonymousTapGesture = UITapGestureRecognizer()
    var notificationsTapGesture = UITapGestureRecognizer()
    var messagesTapGesture = UITapGestureRecognizer()
    var settingsTapGesture = UITapGestureRecognizer()
    var feedbackTapGesture = UITapGestureRecognizer()
    var logoutTapGesture = UITapGestureRecognizer()
    
    var userPicArray = [String]()
    var nameArray =  [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        var usernameSet: String = ""
        if(defaults.string(forKey: "username") != nil){
            usernameSet = defaults.string(forKey: "username")!
        }
        
        let myUrl = URL(string: "http://www.bruincave.com/m/android/bringuserdata.php");
        
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "POST"// Compose a query string
        
        let postString = "user="+usernameSet;
        
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            
            //Let's convert response sent from a server side script toa NSDictionary object:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if json != nil {
                    
                    if let postArray = json?["userdata"] as? NSArray {
                        for post in postArray{
                            if let postDict = post as? NSDictionary {
                                if let userPic: String = postDict.value(forKey: "userpic") as? String {
                                    self.userPicArray.append(userPic)
                                }
                                if let name: String  = postDict.value(forKey: "name") as? String {
                                    self.nameArray.append(name)
                                }
                                
                            }
                        }
                    }
                }
                
                DispatchQueue.main.async { // Correct
                    self.nameLabel.text = self.nameArray[0]
                    
                    //change to school later
                    self.schoolLabel.text = "Branham High"
                    
                    let postimgURL = NSURL(string: self.userPicArray[0])
                    
                    if postimgURL != nil {
                        let data = NSData(contentsOf: (postimgURL as URL?)!)
                        self.userImage.layer.borderWidth = 1
                        self.userImage.layer.masksToBounds = false
                        self.userImage.layer.borderColor = UIColor.black.cgColor
                        self.userImage.layer.cornerRadius = self.userImage.frame.height/2
                        self.userImage.clipsToBounds = true
                        self.userImage.image = UIImage(data:  data! as Data)
                    }
                }
                
                
            } catch {
                print(error)
            }
        }
        
        
        task.resume()
        
        
        
        // On HomeView Tapped
        homeTapGesture = UITapGestureRecognizer(target: self, action: #selector(NavigationViewController.homeViewTapped(_:)))
        homeTapGesture.numberOfTapsRequired = 1
        homeTapGesture.numberOfTouchesRequired = 1
        homeView.addGestureRecognizer(homeTapGesture)
        homeView.isUserInteractionEnabled = true
        
        // On AnonymousView Tapped
        anonymousTapGesture = UITapGestureRecognizer(target: self, action: #selector (NavigationViewController.anonymousViewTapped(_:)))
        anonymousTapGesture.numberOfTapsRequired = 1
        anonymousTapGesture.numberOfTouchesRequired = 1
        anonymousView.addGestureRecognizer(anonymousTapGesture)
        anonymousView.isUserInteractionEnabled = true
        
        // On NotificationsView Tapped
        notificationsTapGesture = UITapGestureRecognizer(target: self, action: #selector (NavigationViewController.notificationsViewTapped(_:)))
        notificationsTapGesture.numberOfTapsRequired = 1
        notificationsTapGesture.numberOfTouchesRequired = 1
        notificationsView.addGestureRecognizer(notificationsTapGesture)
        notificationsView.isUserInteractionEnabled = true
        
        // On MessagesView Tapped
        messagesTapGesture = UITapGestureRecognizer(target: self, action: #selector (NavigationViewController.messagesViewTapped(_:)))
        messagesTapGesture.numberOfTapsRequired = 1
        messagesTapGesture.numberOfTouchesRequired = 1
        messagesView.addGestureRecognizer(messagesTapGesture)
        messagesView.isUserInteractionEnabled = true
        
        // On SettingsView Tapped
        settingsTapGesture = UITapGestureRecognizer(target: self, action: #selector (NavigationViewController.settingsViewTapped(_:)))
        settingsTapGesture.numberOfTapsRequired = 1
        settingsTapGesture.numberOfTouchesRequired = 1
        settingsView.addGestureRecognizer(settingsTapGesture)
        settingsView.isUserInteractionEnabled = true
        
        // On FeedbackView Tapped
        feedbackTapGesture = UITapGestureRecognizer(target: self, action: #selector (NavigationViewController.feedbackViewTapped(_:)))
        feedbackTapGesture.numberOfTapsRequired = 1
        feedbackTapGesture.numberOfTouchesRequired = 1
        feedbackView.addGestureRecognizer(feedbackTapGesture)
        feedbackView.isUserInteractionEnabled = true
        
        // On LogoutView Tapped
        logoutTapGesture = UITapGestureRecognizer(target: self, action: #selector (NavigationViewController.logoutViewTapped(_:)))
        logoutTapGesture.numberOfTapsRequired = 1
        logoutTapGesture.numberOfTouchesRequired = 1
        logoutView.addGestureRecognizer(logoutTapGesture)
        logoutView.isUserInteractionEnabled = true

    }
    @objc func homeViewTapped(_ sender: UITapGestureRecognizer) {
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "homeView") as! SWRevealViewController
        self.present(homeVC, animated: true, completion: nil)
    }
    @objc func anonymousViewTapped(_ sender: UITapGestureRecognizer) {
        let trackingVC = self.storyboard?.instantiateViewController(withIdentifier: "anonymousView") as! SWRevealViewController
        self.present(trackingVC, animated: true, completion: nil)
    }
    @objc func notificationsViewTapped(_ sender: UITapGestureRecognizer) {
        let trackingVC = self.storyboard?.instantiateViewController(withIdentifier: "notificationsView") as! SWRevealViewController
        self.present(trackingVC, animated: true, completion: nil)
    }
    @objc func messagesViewTapped(_ sender: UITapGestureRecognizer) {
        let trackingVC = self.storyboard?.instantiateViewController(withIdentifier: "messagesView") as! SWRevealViewController
        self.present(trackingVC, animated: true, completion: nil)
    }
    @objc func settingsViewTapped(_ sender: UITapGestureRecognizer) {
        
    }
    @objc func feedbackViewTapped(_ sender: UITapGestureRecognizer) {
        
    }
    @objc func logoutViewTapped(_ sender: UITapGestureRecognizer) {
        let defaults = UserDefaults.standard
        defaults.set(nil, forKey: "username")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "loginView") as! ViewController
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
