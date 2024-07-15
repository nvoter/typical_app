//
//  UserProfile.swift
//  TypicalApp
//
//  Created by Анастасия on 15.07.2024.
//

import SwiftUI

struct UserProfile: Identifiable {
    var id = UUID()
    var firstName: String
    var lastName: String
    var email: String
    var avatar: UIImage?
}
