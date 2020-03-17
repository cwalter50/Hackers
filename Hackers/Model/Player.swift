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
    var role: Role
    
    init(name: String) {
        uid = NSUUID().uuidString
        self.name = name
        created = Double(Date().timeIntervalSince1970)
        role = Roles.citizen
    }
    
    init(snapshot: DataSnapshot)
    {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        created = snapshotValue["created"] as? Double ?? 0.0
        name = snapshotValue["name"] as? String ?? "Doccy Bear"
        uid = snapshot.key
        // get the role of each player... Set it to citizen if nother special is assigned.
        let roleName = snapshotValue["role"] as? String ?? Names.citizen
        switch roleName {
        case Names.citizen:
            role = Roles.citizen
        case Names.hacker:
            role = Roles.hacker
        case Names.programmer:
            role = Roles.programmer
        case Names.forensicDetective:
            role = Roles.forensicDetective
        default:
            role = Roles.citizen
        }
    }
    
    func toValues() -> [String:Any]
    {
        return ["uid": uid,
                "name": name,
                "role": role.name,
                "created": created
        ]
    }
}
