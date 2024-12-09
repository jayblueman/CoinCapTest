//
//  MainView.swift
//  TestList
//
//  Created by Adrián Juhász on 2024. 12. 09..
//

import SwiftUI

struct MainView: View {

    @StateObject var viewModel: MainViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                   Spacer()
                   ProgressView("Loading...")
                       .progressViewStyle(CircularProgressViewStyle())
                       .foregroundColor(.gray)
                       .padding()
                   Spacer()
               } else if !viewModel.errorText.isEmpty {
                    ErrorStateView(errorMessage: viewModel.errorText) {
                        viewModel.fetchAssets()
                    }
                } else if viewModel.filteredAssets.isEmpty {
                    Spacer()
                    EmptyStateView()
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.filteredAssets, id: \.id) { asset in
                                AssetRowView(asset: asset)
                            }
                        }
                        .padding()
                    }
                    .background(Color(.secondarySystemBackground))
                    .scrollDismissesKeyboard(.immediately)
                }

            }
            .background(Color.white)
            .navigationTitle("")
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onAppear {
                viewModel.fetchAssets()
            }
        }
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}
