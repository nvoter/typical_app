//
//  LoginS.swift
//  AuthSUI
//  Created by brfsu on 10.07.2024.
//
import SwiftUI

struct SigninS: View {
    @StateObject private var viewModel = AuthViewModel()
    @Binding var errorState: ErrorState
    
    @State private var authorized = false
    @State private var username = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                VStack(spacing: 20) {
                    
                    TextField("Email", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).onAppear {
                            username = ""
                            password = ""
                        }
                    PasswordTextField("Password", text: $password, isSecure: !isPasswordVisible)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay {
                            HStack {
                                Spacer()
                                Button {
                                    isPasswordVisible.toggle()
                                } label: {
                                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.secondary)
                                }
                                .padding(.trailing, 8)
                            }
                        }
                    
                    Button {
                        let body: [String: Any] = [
                            "email": username,
                            "password": password
                        ]
                        viewModel.postRequest(endpoint: "signIn", body: body, callback: { token in
                            if token.count > 0 {
                                print(token)
                                authorized = true
                                UserDefaults.standard.setValue("true", forKey: "isAuth")
                                print("saved")
                                errorState = .Success(message: "You are signed in successfully.")
                            }
                        })
                    } label: {
                        Text("Login")
                            .font(.system(size: 25, weight: .bold))
                            .frame(width: 200, height: 50)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    
                    // go back
                    Button {
                        dismiss()
                    } label: {
                        Text("Back")
                            .font(.system(size: 25, weight: .bold))
                            .frame(width: 200, height: 40)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }.navigate(to: MainS(errorState: $errorState), when: $authorized)
            }.padding()
        }
        .onReceive(viewModel.$errorState) { newState in
            if case .Success(_) = errorState {
                if case .None = newState {
                    return
                }
            }
            withAnimation {
                errorState = newState
            }
        }
        .navigationTitle("Sign in")
        .overlay (
            ErrorView(errorState: $errorState)
        )
    }
}
