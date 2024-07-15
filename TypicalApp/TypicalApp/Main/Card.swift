//
//  Card.swift
//  TypicalApp
//
//  Created by Анастасия on 15.07.2024.
//

import Foundation

struct Card: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var description: String
    var tags: [String]
}
