//
//  NameVC.swift
//  Hackers
//
//  Created by Christopher Walter on 3/4/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import UIKit
import Firebase

class NameVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var roomCodeLabel: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
    var player: Player?
    var party: Party?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let party = party
        {
            roomCodeLabel.text = party.roomCode
        }
        
    }
    
    @IBAction func joinButtonTapped(_ sender: UIButton) {
        if let theParty = party
        {
            if nameTF.text != ""
            {
                // join the party and add name to party.
                player = Player(name: nameTF.text ?? "no name entered")
                if let thePlayer = player
                {
                    // write the room to firebase
                    let ref = Database.database().reference().child("rooms").child(theParty.roomCode).child("players").child(thePlayer.uid)
                    ref.setValue(thePlayer.toValues()) {
                        err, ref in
                        if let error = err
                        {
                            print(error.localizedDescription)
                        }
                        else
                        {
                            print("successfully added player \(thePlayer.name) to the room \(theParty.roomCode)")
                            self.performSegue(withIdentifier: "joinGameSegue", sender: self)
                        }
                    }
                }
            }
            else
            {
                // make up a random fake name and join the party
                
            }
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "joinGameSegue"
        {
            let destVC = segue.destination as! WaitingRoomVC
            destVC.party = party
            destVC.player = player
        }
    }

}
