//
//  MainAuthS.swift
//  AuthSUI8
//  Created by brfsu on 10.07.2024.
//
import SwiftUI

struct MainAuthS: View {
    @State private var errorState: ErrorState = .None
    @StateObject var themeManager = ThemeManager()
    
    var body: some View {
        NavigationView {
            VStack {
                signInButtonV()
                resetPasswordButtonV()
                signUpButtonV()
                deleteUserAccountButtonV()
                toMainViewButtonV()
            }
            .navigationTitle("Auth")
        }
    }
    
    @ViewBuilder func resetPasswordButtonV() -> some View {
        NavigationLink(destination: ResetS(errorState: $errorState)) {
            Text("Reset password")
        }
        .font(.system(size: 25, weight: .bold))
        .frame(width: 200, height: 30).padding()
        .background(Color.black)
        .foregroundColor(.white)
        .cornerRadius(10)
    }

    @ViewBuilder func signUpButtonV() -> some View {
        NavigationLink(destination: SignupS(errorState: $errorState)) {
            Text("Sign up")
        }
        .font(.system(size: 25, weight: .bold))
        .frame(width: 200, height: 30).padding()
        .background(Color.black)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
    
    @ViewBuilder func signInButtonV() -> some View {
        NavigationLink(destination: SigninS(errorState: $errorState)) {
            Text("Sign in")
        }
        .font(.system(size: 25, weight: .bold))
        .frame(width: 200, height: 30).padding()
        .background(Color.black)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
    
    @ViewBuilder func deleteUserAccountButtonV() -> some View {
        NavigationLink(destination: DropS(errorState: $errorState)) {
            Text("Delete account")
        }
        .font(.system(size: 25, weight: .bold))
        .frame(width: 200, height: 30).padding()
        .background(Color.black)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
    
    @ViewBuilder func toMainViewButtonV() -> some View {
        NavigationLink { 
            MainTabView()
                .environmentObject(themeManager)
        } label: {
            Text("Skip auth")
        }
        .font(.system(size: 25, weight: .bold))
        .frame(width: 200, height: 30).padding()
        .background(Color.red)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}
