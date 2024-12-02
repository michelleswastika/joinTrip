//
//  CreateTripView.swift
//  joinTrip
//
//  Created by Michelle Swastika on 08/11/24.
//

import SwiftUI

struct CreateTripView: View {
    @EnvironmentObject var viewModel: CreateTripViewModel

    var body: some View {
        VStack {
            Text("Create a New Trip")
                .font(.title)
                .padding()

            VStack(alignment: .leading, spacing: 10) {
                Text("Trip Name: Summer Vacation")
                Text("Currency: USD")
                Text("Start Date: 2024-12-01")
                Text("End Date: 2024-12-15")
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)

            if viewModel.isLoading {
                ProgressView("Creating Trip...")
            } else {
                Button("Create") {
                    Task {
                        await viewModel.createTrip()
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    CreateTripView()
        .environmentObject(CreateTripViewModel())
}
