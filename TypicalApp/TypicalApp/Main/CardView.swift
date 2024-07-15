//
//  CardView.swift
//  TypicalApp
//
//  Created by Анастасия on 15.07.2024.
//

import SwiftUI

struct CardView: View {
    var card: Card
    
    var body: some View {
        VStack(alignment: .leading) {
            Text (card.title)
                .font(.headline)
            Text (card.description)
                .font(.subheadline)
                .lineLimit(2)
                .padding (.top, 5)
            HStack {
                ForEach(card.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                }
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
