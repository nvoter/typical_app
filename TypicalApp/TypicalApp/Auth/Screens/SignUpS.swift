//
//  SignupS.swift
//  AuthSUI
//  Created by brfsu on 10.07.2024.
//
import SwiftUI

struct SignupS: View
{
    @StateObject private var viewModel = AuthViewModel()
    @Binding var errorState: ErrorState
    
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @State private var secretResponse = ""
    @State private var isPasswordVisible = false
    @State private var authorized = false

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack {
                TextField("Name", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).onAppear {
                        username = ""
                        password = ""
                        email = ""
                        secretResponse = ""
                    }
                
                TextField("Surname", text: $secretResponse)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

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

                // Defining registration button
                Button {
                    let body: [String: Any] = [
                        "name": username,
                        "password": password,
                        "email": email,
                        "surname": secretResponse
                    ]
                    viewModel.postRequest(endpoint: "signUp", body: body, callback: { token in
                        if token.count > 0 {
                            print(token)
                            authorized = true
                            errorState = .Success(message: "You are registered successfully.")
                        }
                    })
                } label: {
                    Text("Register")
                        .font(.system(size: 25, weight: .bold))
                        .frame(width: 200, height: 50)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 5)
                        }
                }
                
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
                
            }
            .navigate(to: MainS(errorState: $errorState), when: $authorized)
            .padding()
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
        .navigationTitle("Sign up")
        .overlay (
            ErrorView(errorState: $errorState)
        )
    }
}
