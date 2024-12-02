//
//  Home.swift
//  joinTrip
//
//  Created by Michelle Swastika on 05/11/24.
//

import SwiftUI

struct Home: View {
    @State private var showPopup = false
    @State private var navigateToJoinCode = false
    @State private var showCreateTripSheet = false

    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    NavigationLink(destination: JoinWithCodeView(), isActive: $navigateToJoinCode) {
                        EmptyView()
                    }
                    Button("Join Trip") {
                        showPopup = true
                    }
                }
            }
            if showPopup {
                PopupView(showPopup: $showPopup, navigateToJoinCode: $navigateToJoinCode, showCreateTripSheet: $showCreateTripSheet)
            }
        }
        .sheet(isPresented: $showCreateTripSheet) {
            CreateTripFlowView()
                .presentationDetents([.medium])
        }
    }
}

struct PopupView: View {
    @Binding var showPopup: Bool
    @Binding var navigateToJoinCode: Bool
    @Binding var showCreateTripSheet: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 16) {
                HStack {
                    Spacer()
                    Button(action: {
                        showPopup = false
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }

                Button("Create Trip") {
                    showPopup = false
                    showCreateTripSheet = true
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("Join with Code") {
                    showPopup = false
                    navigateToJoinCode = true
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.2))
                .foregroundColor(.blue)
                .cornerRadius(10)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .frame(maxWidth: 300)
        }
    }
}

#Preview {
    Home()
}
