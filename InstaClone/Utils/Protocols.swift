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

protocol FollowCellDelegate {
    func handleFollowTapped(for cell: FollowLikeCell)
}

protocol FeedCellDelegate {
    func handleUsernameTapped(for cell: FeedCell)
    func handleOptionsTapped(for cell: FeedCell)
    func handleLikeTapped(for cell: FeedCell, isDoubleTap: Bool)
    func handleCommentTapped(for cell: FeedCell)
    func handleConfigureLikeButton(for cell: FeedCell)
    func handleShowLikes(for cell: FeedCell)
//    func configureCommentIndicatorView(for cell: FeedCell)
}
