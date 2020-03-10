//
//  Player.swift
//  Hackers
//
//  Created by Christopher Walter on 3/7/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import Foundation
import Firebase

class Player
{
    var uid: String // this will be used so that multiple people in a room can have the same name
    var name: String
    var created: Double // timeSince 1970 as a Double value
    
    init(name: String) {
        uid = NSUUID().uuidString
        self.name = name
        created = Double(Date().timeIntervalSince1970)
    }
    
    init(snapshot: DataSnapshot)
    {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        created = snapshotValue["created"] as? Double ?? 0.0
        name = snapshotValue["name"] as? String ?? "Doccy Bear"
        uid = snapshot.key
    }
    
    func toValues() -> [String:Any]
    {
        return ["uid": uid,
                "name": name,
                "created": created
        ]
    }
}
