//
//  AuthManager.swift
//  joinTrip
//
//  Created by Michelle Swastika on 07/11/24.
//

import Foundation
import Supabase

class AuthManager {
    static let shared = AuthManager()

    private init() {}

    let client = SupabaseClient(supabaseURL: URL(string: "https://rubhvqtdilrfbyhvjnip.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ1Ymh2cXRkaWxyZmJ5aHZqbmlwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzAxNjc0MTAsImV4cCI6MjA0NTc0MzQxMH0.RQKdGX1ZpkayJuJaAdwWZREWfNggWWw852ksEoUqh4I")

    func signInWithApple(idToken: String, nonce: String) async throws {
        let credentials = OpenIDConnectCredentials(provider: .apple, idToken: idToken, nonce: nonce)
        let session = try await client.auth.signInWithIdToken(credentials: credentials)

        print(session)
        print(session.user)
    }

    func logoutFromApple() async throws {
        try await client.auth.signOut()
    }
}
