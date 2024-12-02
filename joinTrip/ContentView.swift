//
//  ContentView.swift
//  joinTrip
//
//  Created by Michelle Swastika on 05/11/24.
//

import SwiftUI

struct ContentView: View {
    var trip: Trip?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let trip = trip {
                Text("Trip Name: \(trip.name)")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Currency: \(trip.currency)")
                Text("Trip Code: \(trip.trip_code)")
                Text("Total: \(String(format: "%.2f", trip.total))")
                Text("Start Date: \(trip.start_date)")
                Text("End Date: \(trip.end_date)")
            } else {
                Text("No trip information available.")
            }
        }
        .padding()
        .navigationTitle("Trip Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
