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
    
    init()
    {
        created = Double(Date().timeIntervalSince1970)
        // create a unique 6 alphanumeric symbols. I created a String extension to do this.
        roomCode = String.randomString(length: 6)
    }
    
    init(snapshot: DataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        created = snapshotValue["created"] as? Double ?? 0.0
        roomCode = snapshot.key
               
    }
    
    func toValues() -> [String: Any]
    {
        return ["created": created,
                "roomCode": roomCode
        ]
    }
    
}
