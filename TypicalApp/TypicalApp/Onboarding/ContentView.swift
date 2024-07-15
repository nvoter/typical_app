//
//  ContentView.swift
//  TypicalApp
//
//  Created by Анастасия on 15.07.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var currentPage = 0
    
    let pages = [
            OnboardingData(image: "img1", title: "Привет!", description: "Добро пожаловать!"),
            OnboardingData(image: "img2", title: "Функции", description: "Откройте новые функции"),
            OnboardingData(image: "img3", title: "Начнем", description: "Давайте начнем")
        ]

    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    OnboardingView(data: pages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            HStack {
                if currentPage > 0 {
                    Button("Назад", action: { currentPage -= 1 })
                }
                Spacer()
                if currentPage < pages.count - 1 {
                    Button ("Далее", action: { currentPage += 1 })
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
