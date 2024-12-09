//
//  EmptyStateView.swift
//  TestList
//
//  Created by Adrián Juhász on 2024. 12. 09..
//

import SwiftUI


struct EmptyStateView: View {
    var body: some View {
        VStack {
            Image("IconEmpty")
                .resizable()
                .scaledToFit()
                .frame(width: 145, height: 143)
                .foregroundColor(.gray)
            Text("No result")
                .font(Font.system(size: 30, weight: .bold))
                .foregroundColor(.gray)
        }
        .padding()
    }
}

#Preview {
    EmptyStateView()
}
