//
//  Protocols.swift
//  InstaClone
//
//  Created by mitsuyoshi matsuo on 2019/04/22.
//  Copyright © 2019 mitsuyoshi matsuo. All rights reserved.
//

import Foundation

protocol UserProfileHeaderDelegate {
    
    func handleEditFollowTapped(for header: UserProfileHeader)
    func setUserStats(for header: UserProfileHeader)
    func handleFollowersTapped(for header: UserProfileHeader)
    func handleFollowingTapped(for header: UserProfileHeader)
}
