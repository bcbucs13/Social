//
//  FeedViewController.swift
//  devlopes-social
//
//  Created by Marissa Dietz on 1/12/17.
//  Copyright © 2017 Carter Apps. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            print("Snapshot value = \(snapshot.value)")
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("Snap = \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                        
                    }
                }
            }
            self.tableView.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tableView: UITableView!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            cell.configureCell(post: post)
            return cell
        
        } else {
            return PostCell()
        }
        
    }
    
    @IBAction func signOutPressed(_ sender: UITapGestureRecognizer) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        //(forKey: KeychainWrapper.standard.string(forKey: KEY_UID)!)
        print("BRAD: ID removed from keychian \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "segueToSignIn", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
