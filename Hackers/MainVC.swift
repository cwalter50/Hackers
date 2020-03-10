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
    
    var party: Party?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startPartyButton.titleLabel?.adjustsFontSizeToFitWidth = true
        startPartyButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
    }
    
    @IBAction func startPartyTapped(_ sender: UIButton) {

        
        party = Party()
        
        // write the room to firebase
        let ref = Database.database().reference().child("rooms")
        
        if let theParty = party
        {
            let values: [String: Any] = theParty.toValues()
            ref.child(theParty.roomCode).setValue(values) { (err, ref) in
                if let error = err
                {
                    print(error.localizedDescription)
                }
                else
                {
                    print("successfully created a new room \(theParty.roomCode)")
                    self.performSegue(withIdentifier: "createPartySegue", sender: self)
                }
            }
        }
        
    }
    @IBAction func joinPartyTapped(_ sender: UIButton) {
        let partyCode = joinPartyTF.text ?? ""
        
        // observe firebase for room...
        let ref = Database.database().reference().child("rooms")
        
        ref.child(partyCode).observeSingleEvent(of: .value, with: {snapshot in
            if !snapshot.exists() {
                print("couldn't find room with that code")
                self.errorAlert(message: "Couldn't find room with code: \(partyCode)")
                return
            }
            self.party = Party(snapshot: snapshot)
            print("successfully found room \(self.party?.roomCode ?? "no room code")")
            self.performSegue(withIdentifier: "joinPartySegue", sender: self)
        })
        
        
    }
    
    func errorAlert(message: String)
    {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createPartySegue" || segue.identifier == "joinPartySegue"
        {
            let destVC = segue.destination as! NameVC
            destVC.party = party
        }
        
    }

}
