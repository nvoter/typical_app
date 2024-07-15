//
//  OnboardingView.swift
//  TypicalApp
//
//  Created by Анастасия on 15.07.2024.
//

import SwiftUI

struct OnboardingView: View {
    var data: OnboardingData
    
    var body: some View {
        VStack {
            Image(data.image)
            Text(data.title).font(.largeTitle)
            Text(data.description).font(.body)
        }
    }
}
