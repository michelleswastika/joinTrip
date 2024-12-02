//  JoinWithCodeView.swift
//  joinTrip
//
//  Created by Michelle Swastika on 05/11/24.

import SwiftUI
import Supabase

struct JoinWithCodeView: View {
    @FocusState private var isFieldFocused: Bool
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var textFieldValue: String = ""
    @State private var navigateToContentView = false
    @State private var trip: Trip? // New state variable to store the trip details

    let client = AuthManager.shared.client

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ContentView(trip: trip).navigationBarBackButtonHidden(true), isActive: $navigateToContentView) {
                    EmptyView()
                }
                
                Image("18268598_5954626")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                Text("Input the code shared by your friend to connect to their trip.")
                    .multilineTextAlignment(.center)
                    .padding()
                
                TextField("Enter code", text: $textFieldValue)
                    .focused($isFieldFocused)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(showError ? Color.red : Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .padding(.horizontal)
                    .padding()
                
                if showError {
                    HStack(alignment: .center) {
                        Image(systemName: "exclamationmark.circle")
                            .foregroundColor(.red)
                        
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
                    .padding(.horizontal)
                    .padding(.top, -10)
                    .padding(.bottom, 10)
                }
                
                Button("Join Trip") {
                    Task {
                        if textFieldValue.isEmpty {
                            showError = true
                            errorMessage = "Code cannot be empty. Please enter a code!"
                        } else if textFieldValue.count == 10 && textFieldValue.range(of: "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]{10}$", options: .regularExpression) != nil {
                            await checkIfCodeExists(code: textFieldValue)
                        } else {
                            showError = true
                            errorMessage = "Invalid code. Please try again!"
                        }
                    }
                }
                .font(.headline)
                .padding()
                .background(Color.blue.opacity(0.6))
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .navigationTitle("Join with Code")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                isFieldFocused = true
            }
        }
    }

    @MainActor
    private func checkIfCodeExists(code: String) async {
        let trimmedCode = code.trimmingCharacters(in: .whitespacesAndNewlines)
        
        do {
            let response = try await client
                .from("trips")
                .select("*")
                .eq("trip_code", value: trimmedCode)
                .limit(1)
                .execute()
            
            if let trips = try JSONSerialization.jsonObject(with: response.data) as? [[String: Any]], let tripData = trips.first {
                // Decode trip data
                let trip = Trip(
                    name: tripData["name"] as? String ?? "",
                    currency: tripData["currency"] as? String ?? "",
                    trip_code: tripData["trip_code"] as? String ?? "",
                    total: tripData["total"] as? Double ?? 0.0,
                    start_date: tripData["start_date"] as? String ?? "",
                    end_date: tripData["end_date"] as? String ?? ""
                )
                
                self.trip = trip
                navigateToContentView = true
                showError = false
            } else {
                showError = true
                errorMessage = "Trip code not found. Please try again!"
            }
        } catch {
            showError = true
            errorMessage = "An error occurred: \(error.localizedDescription)"
        }
    }
}

#Preview {
    JoinWithCodeView()
}
