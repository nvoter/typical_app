//
//  TypicalAppApp.swift
//  TypicalApp
//
//  Created by Анастасия on 15.07.2024.
//

import SwiftUI


@main
struct TypicalAppApp: App {
    @StateObject var themeManager = ThemeManager()
    var isOnboarded = true
    
    var body: some Scene {
        WindowGroup {
            if isOnboarded {
                MainTabView()
                    .environmentObject(themeManager)
            } else {
                ContentView()
            }
        }
    }
}

struct MainTabView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        TabView {
            MainContentView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text ("Cards")
                }
            ProfileView()
                .tabItem {
                    Image (systemName: "person.circle")
                    Text ("Profile")
                }
        }
        .background(themeManager.currentTheme.backgroundColor)
    }
}
