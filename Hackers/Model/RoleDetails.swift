//
//  RoleDetails.swift
//  Hackers
//
//  Created by Christopher Walter on 3/15/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import Foundation

struct Names
{
    static let hacker = "Hacker"
    static let forensicDetective = "Forensic Detective"
    static let programmer = "Programmer"
    static let citizen = "Citizen"
}

struct RoleAbouts
{
    static let aboutHacker = "A Hacker wants to hack everybodies computers and steal all of their private information. Each day they will chose one other player in the game to hack. If a programmer does not protect that hacked player in the same day, the hacker will successfully steal all of the player's information and that hacked player will be out of the game. Hackers win the game if their are more hackers than all of the other players combined. Hackers also know the identity of all the other hackers in the game."
    static let aboutProgrammer = "A Programmer wants to protect everybodies computers from the hackers. Each day they can choose one other player to protect or they can protect themselves from being hacked. If they chose correctly, they will know the identity of the hacker and the protected player will still be in the game. The programmer wins if they eliminate all the hackers."
    static let aboutForensicDetective = "A Forensic Detective is allowed to guess if a player is a Hacker each day. Their guess will be confirmed or denied. They can use this knowledge however they like. Revealing the name will most likely make them a target by the Hacker. A Forensic Detective wins if all the Hackers are eliminated from the game."
    static let aboutCitizen = "A Citizen has a computer with private information. If a Hacker hacks their computer, the citizen will lose their private information and be eliminated from the game. Each day they will cast a vote towards another player in the game. Each day the person with the most votes will be eliminated from the game."
}

struct RoleDirections
{
    static let hackerDirections = "Choose one player in the game to hack their computer and steal their private information. If the player is not prtected by a programmer, they will be eliminated from the game."
    
    static let programmerDirections = "Choose one player in the game to protect from getting hacked. You can protect yourself or another player. If a hacker targets that player, you will save their information and they will not be eliminated and the Hackers identity will be revealed to you."
    static let forensicDetectiveDirections = "Choose one player who you think is the hacker. Your suspician will be either confirmed or denied. What you do with that knowledge is your choice."
    static let citizenDirections = "Choose one player to vote to eliminate from the game. At the end of the day, the player with the most votes will be eliminated."
}

public struct Roles
{
    static var hacker = Role(name: Names.hacker, about: RoleAbouts.aboutHacker, directions: RoleDirections.hackerDirections)
    static var programmer = Role(name: Names.programmer, about: RoleAbouts.aboutHacker, directions: RoleDirections.hackerDirections)
    static var forensicDetective = Role(name: Names.forensicDetective, about: RoleAbouts.aboutForensicDetective, directions: RoleDirections.forensicDetectiveDirections)
    static var citizen = Role(name: Names.citizen, about: RoleAbouts.aboutCitizen, directions: RoleDirections.citizenDirections)
}



