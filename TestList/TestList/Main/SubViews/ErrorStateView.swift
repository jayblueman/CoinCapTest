//
//  ErrorStateView.swift
//  TestList
//
//  Created by Adrián Juhász on 2024. 12. 09..
//

import SwiftUI

struct ErrorStateView: View {
    var errorMessage: String
    var onRetry: () -> Void

    var body: some View {
        VStack {
            Spacer()

            Image("IconError")
                .resizable()
                .scaledToFit()
                .frame(width: 159, height: 120)
                .foregroundColor(.gray)

            Text("Connection Error")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.gray)

            Text("Lorem ipsum dolor sit amet")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)

            Button(action: onRetry) {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("Retry")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(8)
            }
            .padding(.horizontal, 40)
            .padding(.top, 24)

            Spacer()

            Text("Reason: \(errorMessage)")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, 16)
        }
        .padding()
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ErrorStateView(errorMessage: "test reason ") {
        
    }
}
