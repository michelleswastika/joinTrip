//
//  TripCreatedView.swift
//  joinTrip
//
//  Created by Michelle Swastika on 08/11/24.
//

import SwiftUI

struct TripCreatedView: View {
    let tripCode: String
    let creationFailed: Bool

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if creationFailed {
                    Text("Trip Creation Failed!")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                        .padding(.top, 20)
                    
                    Text("An error occurred while creating the trip. Please try again.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("Trip Created!")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    
                    Text("Share this code with friends to join your trip:")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    HStack(spacing: 8) {
                        Text(tripCode)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding(.top, 20)

                        Button(action: {
                            UIPasteboard.general.string = tripCode
                        }) {
                            Image(systemName: "doc.on.doc")
                                .foregroundColor(.blue)
                        }
                    }

                    Button(action: {
                        // Add sharing functionality here
                    }) {
                        Text("Share with Friends")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: 200)
                            .background(Color.blue.opacity(0.2))
                            .foregroundColor(.blue)
                            .cornerRadius(25)
                    }
                    .padding(.top, 80)
                }
            }
            .padding()
            .navigationTitle("Create Trip")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 40, height: 5)
                        .padding(.top, 8)
                }
            }
        }
    }
}

#Preview {
    TripCreatedView(tripCode: "ABc123Xyz9", creationFailed: false)
}
