//
//  InputCode.swift
//  joinTrip
//
//  Created by Michelle Swastika on 05/11/24.

import SwiftUI

struct AssetNames {
    static let inputFieldBackground = "input_field_background"
}

// Usage example in a view:
struct InputCode: View {
    @Binding var textFieldValue: String
    
    var body: some View {
        VStack {
            TextField("Enter trip code", text: $textFieldValue)
                .padding()
                .background(
                    Image(AssetNames.inputFieldBackground)
                        .resizable()
                        .scaledToFill()
                )
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                .padding(.horizontal)
        }
    }
}

#Preview {
    InputCode(textFieldValue: .constant(""))
}
