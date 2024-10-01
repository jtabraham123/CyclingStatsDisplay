//
//  AuthenticationService.swift
//  StravaApp
//
//  Created by Jack Abraham on 9/29/24.
//

import Foundation
import AuthenticationServices

/*
    Authentication service handles network activity to authenticate the user including an initial OAuthURL visit
 and a request made to the stravaAPI to recieve the OAuth Token.
 */
class AuthenticationService {
    
    private var authSession: ASWebAuthenticationSession?
    private var appOAuthUrlStravaScheme: URL?
    private var webOAuthUrl: URL?
    private var authViewProvider: AuthenticationViewProvider?
    private let redirectURI = "CyclingStatsDisplay://jtabraham123.github.io/CyclingStatsDisplayhtml/redirect.html"
    private let clientID = 136335
    private let responseType = "code"
    private let scope = "profile:read_all"
    private let appBaseURL = "strava://oauth/mobile/authorize"
    private let webBaseURL = "https://www.strava.com/oauth/mobile/authorize"
    private let stravaAPIService: StravaAPIService
    
    private let authURL = URL(string: "https://www.strava.com/api/v3/oauth/token")
    
    
    private var authorizationPostData: [String: String] = [
        "client_id": "136335",
        "client_secret": "85d838f7b2f7dd23729af4abb947143905b7d001",
        "grant_type": "authorization_code"
    ]
    
    
    init(stravaAPIService: StravaAPIService) {
        self.stravaAPIService = stravaAPIService
        let queryItems = [
            URLQueryItem(name: "client_id", value: String(clientID)),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "response_type", value: responseType),
            URLQueryItem(name: "scope", value: scope)
        ]
        var appURL = URLComponents(string: self.appBaseURL)
        var webURL = URLComponents(string: self.webBaseURL)
        appURL?.queryItems = queryItems
        webURL?.queryItems = queryItems
        if let finalAppURL = appURL, let finalWebURL = webURL {
            self.appOAuthUrlStravaScheme = finalAppURL.url
            self.webOAuthUrl = finalWebURL.url
        }
    }
    
    //passes in UIWindow for Web based Authorization
    func registerWindow() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            authViewProvider = AuthenticationViewProvider(window: window)
        }
    }
    
    // Makes post request for accesstoken and sets the token and athleteID in the StravaAPIService
    // upon calling completion with success will trigger navigation event to the StravaStatsView
    func getAccessToken(code: String, completion: @escaping (Result<String, Error>)-> Void) {
        self.authorizationPostData["code"] = code
        
        if let url = authURL {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let bodyString = self.authorizationPostData.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            request.httpBody = bodyString.data(using: .utf8)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let data = data {
                    do {
                        // successful authentication
                        let decoder = JSONDecoder()
                        let authData = try decoder.decode(AuthResponse.self, from: data)
                        self.stravaAPIService.setTokenAndAthleteID(authToken: authData.access_token, athleteID: authData.athlete.id)
                        let name = authData.athlete.firstname + " " + authData.athlete.lastname
                        completion(.success((name)))
                    } catch {
                        completion(.failure(NetworkError.invalidData))
                    }
                }
                else {
                    completion(.failure(NetworkError.invalidData))
                }
            }
            task.resume()
        }
        else {
            completion(.failure(NetworkError.invalidURL))
        }
    }
    
    // takes in result URL after initial OAuth URL visit, extracts code for authorization and calls getAccessToken to get
    // access Token which allows for access to the complete Strava API
    func authenticateWithURL(url: URL?, error: Error?, completion: @escaping (Result<String, Error>) -> Void) {
        if let url = url {
            completion(.failure(NetworkError.invalidData))
            
            if let error = error {
                completion(.failure(error))
            }
            // parse the url
            if let components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                components.queryItems?.forEach { item in
                    if (item.name == "code") {
                        if let code = item.value {
                            self.getAccessToken(code: code, completion: completion)
                        }
                    }
                    if (item.name == "error") {
                        completion(.failure(NetworkError.authenticationError))
                    }
                }
            }
        }
    }
    
    // starts authentication process either with the Strava app or with the Strava website online
    func authenticate(completion: @escaping (Result<String, Error>) -> Void) {
        if let oAuthStravaScheme = appOAuthUrlStravaScheme, let oAuthURLWeb = webOAuthUrl {
            if UIApplication.shared.canOpenURL(oAuthStravaScheme) {
                UIApplication.shared.open(oAuthStravaScheme, options: [:])
            } else {
                authSession = ASWebAuthenticationSession(url: oAuthURLWeb, callbackURLScheme: "CyclingStatsDisplay") { url, error in
                    self.authenticateWithURL(url: url, error: error, completion: completion)
                }
                if let viewProvider = authViewProvider {
                    authSession?.presentationContextProvider = viewProvider
                }
                authSession?.start()
            }
        }
        else {
            completion(.failure(NetworkError.invalidURL))
        }
    }
}
