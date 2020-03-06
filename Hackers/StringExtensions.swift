//
//  StringExtensions.swift
//  Hackers
//
//  Created by Christopher Walter on 3/5/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import Foundation


extension String
{
    static func randomString(length: Int) -> String {
      let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
