//
//  MainVC.swift
//  Hackers
//
//  Created by Christopher Walter on 3/4/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import UIKit
import Firebase

class MainVC: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var startPartyButton: UIButton!
    @IBOutlet weak var joinPartyButton: UIButton!
    @IBOutlet weak var joinPartyTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func startPartyTapped(_ sender: UIButton) {
        // create a unique 6 alphanumeric symbols. I created a String extension to do this.
        let randomString = String.randomString(length: 6)
        
        print(randomString)
        
        // write the room to firebase
        let ref = Database.database().reference().child("rooms")
        
        let values: [String: Any] = ["roomCode" : randomString, "created" : Double(Date().timeIntervalSince1970)]
        ref.child(randomString).setValue(values) { (err, ref) in
            if let error = err
            {
                print(error.localizedDescription)
            }
            else
            {
                print("successfully created a new room \(randomString)")
            }
        }
        
        
    }
    @IBAction func joinPartyTapped(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
