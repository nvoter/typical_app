//
//  AuthViewModel.swift
//  AuthSUI
//  Created by brfsu on 10.07.2024.
//
import Foundation

class AuthViewModel: ObservableObject
{
    private let successLoginMessage = "You have successfully logged in."
    @Published var isSuccessAuth = false
    @Published var errorState: ErrorState = .None
//    @Published var loginCounter = 0
    @Published var token = ""
    static let urlSignUp = "http://localhost:3003/users/signUp"
    static let urlApiUsers = "http://localhost:3003/users/"

    init() {
        if (UserDefaults.standard.bool(forKey: "isAuth")) {
            isSuccessAuth = true
        }
        print(isSuccessAuth)
    }

    
    private func validatePassword(password: String) -> Bool {
        let control = #"(?=.{8,})(?=.*[0-9a-zA-Z])(?=.*[!#$%&? "])"#
        if password.range(of: control, options: .regularExpression) != nil {
            //print("true!")
            return true
        }
        //print("false!")
        return false
    }
    
    
    // Server post request // for signup
    func postRequest(endpoint: String = "signUp", body: [String: Any], callback: @escaping (String) -> Void, _ requestType: String = "POST") {
        self.token = ""
        let url = URL(string: "\(AuthViewModel.urlApiUsers)\(endpoint)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = requestType
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("No data received from server")
                return
            }
            
            do {
                let authResponse = try JSONDecoder().decode(RegResponse.self, from: data)
                // token received
                self.errorState = .Success(message: "Successful.")
                UserDefaults.standard.setValue(authResponse.accessToken, forKey: "token")
                self.isSuccessAuth = true
                self.token = authResponse.accessToken
                callback(self.token)
            } catch {
                DispatchQueue.main.async {
                    self.errorState = .Error(message: error.localizedDescription)
                }
                print(error.localizedDescription)
                return
            }
        }.resume()
    }
}
