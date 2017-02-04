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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        DataService.ds.REF_POSTS.observe(.value) { (snapshot) in
            print("Snapshot value = \(snapshot.value)")
        }
        
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell")!
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
