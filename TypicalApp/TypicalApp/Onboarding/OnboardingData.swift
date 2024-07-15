//
//  OnboardingData.swift
//  TypicalApp
//
//  Created by Анастасия on 15.07.2024.
//

import Foundation

struct OnboardingData: Identifiable, Hashable {
    var id = UUID()
    var image: String
    var title: String
    var description: String
}
