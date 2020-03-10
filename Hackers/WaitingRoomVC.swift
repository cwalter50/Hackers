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
                    
                    self.playerTableView.reloadData()
                    
                }
            })
            
            
            
            
            
            
        }
        
        
        
       
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton)
    {
        
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
    
    

}
