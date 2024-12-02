//
//  CreateTripFlowView.swift
//  joinTrip
//
//  Created by Michelle Swastika on 08/11/24.
//

import SwiftUI

struct CreateTripFlowView: View {
    @StateObject private var viewModel = CreateTripViewModel()
    
    var body: some View {
        VStack {
            if viewModel.tripCreated {
                TripCreatedView(tripCode: viewModel.createdTripCode, creationFailed: viewModel.creationFailed)
            } else {
                CreateTripView()
                    .environmentObject(viewModel)
            }
        }
    }
}

#Preview {
    CreateTripFlowView()
}
