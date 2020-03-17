//
//  WaitingRoomVC.swift
//  Hackers
//
//  Created by Christopher Walter on 3/4/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import UIKit
import Firebase

class WaitingRoomVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableViewNavBar: UINavigationBar!
    @IBOutlet weak var playerTableView: UITableView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var roomCodeLabel: UILabel!
    

    
    var party: Party?
    var player: Player? // we need to keep track of the user's player
    var players: [Player] = [Player]()
    {
        didSet {
            tableViewNavBar.topItem?.title = "Players (\(players.count))"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerTableView.delegate = self
        playerTableView.dataSource = self
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let theParty = party
        {
            roomCodeLabel.text = theParty.roomCode
            
            // load the players
            loadPlayers()
        }
    }
    
    func loadPlayers()
    {
        if let theParty = party
        {
            let ref = Database.database().reference().child("rooms").child(theParty.roomCode).child("players")
            ref.keepSynced(true)
            ref.queryOrdered(byChild: "created").observe(.value, with: {snapshot in
                if !snapshot.exists()
                {
                    print("no people in the room")
                    return
                }
                for item in snapshot.children {
                    let player = Player(snapshot: item as! DataSnapshot)
                    // prevent duplicates from being added, because this listener will reload every time a new player jumps in
                    if let i = self.players.firstIndex(where: { $0.uid == player.uid}) {
                        self.players.remove(at: i)
                    }
                    self.players.append(player)
                    theParty.players = self.players
                    
                    self.playerTableView.reloadData()
                    
                }
            })
            
            
            
            
            
            
        }

       
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton)
    {
        assignRoles()
        updatePlayerRolesInFirebase()
        
        if players.count >= 3
        {
            performSegue(withIdentifier: "startGameSegue", sender: self)
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "You need at least 3 players to play the game", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func assignRoles()
    {
        /*
         assign roles...
         1 Hacker for every 8 players
         1 Programmer for every 8 players
         1 forensic Detective for every 8 players
         The rest are citizens
         */
        // figure out how many of each type of player is in players.
        
        // make a roles array to match the number of players
        var roleList = [Role]()
        
        let hackers = players.count / 10 + 1
        let programmers = players.count / 10 + 1
        let forensicDetectives = players.count / 10 + 1
        
        for _ in 0..<hackers
        {
            roleList.append(Roles.hacker)
        }
        for _ in 0..<programmers
        {
            roleList.append(Roles.programmer)
        }
        for _ in 0..<forensicDetectives
        {
            roleList.append(Roles.forensicDetective)
        }
        
        // fill the rest with citizens
        while roleList.count < players.count
        {
            roleList.append(Roles.citizen)
        }
        roleList.shuffle()
        
        // match each player in players with a role from the roleList
        for i in 0..<players.count
        {
            players[i].role = roleList[i]
        }
        
        print("The roles of the players...")
        for player in players
        {
            print("\(player.uid): \(player.name) is a \(player.role.name)")
        }
    }
    
    func updatePlayerRolesInFirebase()
    {
        if let theParty = party
        {
            for player in players
            {
                // write the room to firebase
                let ref = Database.database().reference().child("rooms").child(theParty.roomCode).child("players").child(player.uid)
                ref.setValue(player.toValues()) {
                    err, ref in
                    if let error = err
                    {
                        print(error.localizedDescription)
                    }
                    else
                    {
                        print("successfully updated player \(player.name)'s role to \(player.role.name) to the room \(theParty.roomCode)")
                        
                    }
                }
            }
        }
        
    }
    
    // MARK: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        let currentPlayer = players[indexPath.row]
        
        cell.textLabel?.text = "\(indexPath.row+1): \(currentPlayer.name)"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGameSegue"
        {
            let destVC = segue.destination as! GameVC
            destVC.player = self.player
            destVC.players = self.players
            destVC.party = self.party
        }
    }
    
    

}
