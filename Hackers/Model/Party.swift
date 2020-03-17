//
//  Party.swift
//  Hackers
//
//  Created by Christopher Walter on 3/7/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import Firebase
import Foundation

public class Party
{
    var created: Double //time since 1970 as a double value
    var roomCode: String // 6 alphanumeric code with all capitol letters
    var players: [Player]
    var hasStarted: Bool // this will be used to determine when to stop letting players join the game. Once someone hits start, the game begins
    
    init()
    {
        created = Double(Date().timeIntervalSince1970)
        // create a unique 6 alphanumeric symbols. I created a String extension to do this.
        roomCode = String.randomString(length: 6)
        hasStarted = false
        players = [Player]()
        
    }
    
    init(snapshot: DataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        created = snapshotValue["created"] as? Double ?? 0.0
        hasStarted = snapshotValue["hasStarted"] as? Bool ?? false
        roomCode = snapshot.key
        players = [Player]()
               
    }
    
    func toValues() -> [String: Any]
    {
        return ["created": created,
                "hasStarted": hasStarted,
                "roomCode": roomCode
        ]
    }
    
}
