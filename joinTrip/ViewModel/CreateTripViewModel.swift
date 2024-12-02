//
//  CreateTripViewModel.swift
//  joinTrip
//
//  Created by Michelle Swastika on 08/11/24.
//

import Foundation
import Supabase

@MainActor
class CreateTripViewModel: ObservableObject {
    @Published var tripCreated = false
    @Published var creationFailed = false
    @Published var createdTripCode = ""
    @Published var isLoading = false
    
    // Dummy data
    private let tripName = "Summer Vacation"
    private let currency = "USD"
    private let startDate = "2024-12-01"
    private let endDate = "2024-12-15"
    
    func createTrip() async {
        isLoading = true
        creationFailed = false
        
        // Retry loop in case of duplicate trip code
        for _ in 0..<5 {  // Limit to 5 attempts to prevent infinite loop
            let tripCode = generateTripCode()
            let newTrip = Trip(name: tripName, currency: currency, trip_code: tripCode, total: 0.0, start_date: startDate, end_date: endDate)
            
            do {
                // Attempt to insert data into Supabase trips table
                let response = try await AuthManager.shared.client
                    .from("trips")
                    .insert(newTrip)
                    .execute()
                
                print("Trip created: \(response)")
                createdTripCode = tripCode  // Set the created trip code
                tripCreated = true
                isLoading = false
                return  // Exit the function on success
            } catch let error as PostgrestError {
                if error.code == "23505" {  // Unique violation
                    print("Duplicate trip code detected. Regenerating a new trip code...")
                    continue  // Retry with a new code
                } else {
                    print("Error creating trip: \(error)")
                    creationFailed = true
                    break  // Exit the loop if it's another error
                }
            } catch {
                print("Unexpected error: \(error)")
                creationFailed = true
                break
            }
        }
        
        // If the loop exits without success
        if !tripCreated {
            print("Failed to create a trip after multiple attempts.")
            creationFailed = true
        }
        
        isLoading = false
    }
    
    private func generateTripCode() -> String {
        let lowercaseLetters = "abcdefghijklmnopqrstuvwxyz"
        let uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let numbers = "0123456789"
        
        // Ensure one character from each required set
        let lowercase = lowercaseLetters.randomElement()!
        let uppercase = uppercaseLetters.randomElement()!
        let number = numbers.randomElement()!
        
        // Fill the remaining characters randomly from all sets
        let allCharacters = lowercaseLetters + uppercaseLetters + numbers
        var remainingCharacters = (0..<7).map { _ in allCharacters.randomElement()! }
        
        // Combine all characters
        var tripCode = [lowercase, uppercase, number] + remainingCharacters
        
        // Shuffle the trip code to randomize order
        tripCode.shuffle()
        
        return String(tripCode)
    }
}
