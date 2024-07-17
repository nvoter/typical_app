//
//  ContentView.swift
//  AuthSUI
//  Created by brfsu on 10.07.2024.
//
import SwiftUI

struct StartS: View {
    @State private var errorState: ErrorState = .None
    @State private var viewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            if  viewModel.isSuccessAuth {
                MainS(errorState: $errorState)
            } else {
                MainAuthS()
            }
        }
        .overlay (
            ErrorView(errorState: $errorState)
        )
    }
}
