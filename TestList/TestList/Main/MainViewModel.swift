//
//  MainViewModel.swift
//  TestList
//
//  Created by Adrián Juhász on 2024. 12. 09..
//

import Foundation
import Combine

class MainViewModel: ObservableObject {

    @Published var isLoading: Bool = false

    @Published var assets: [Asset] = []
    @Published var markets: [Market] = []

    @Published var searchText: String = ""
    @Published private(set) var filteredAssets: [Asset] = []

    @Published var errorText: String = "hiba van bro"

    private var cancellables = Set<AnyCancellable>()

    init() {
        Publishers.CombineLatest($searchText, $assets)
            .map { searchText, assets in
                if searchText.isEmpty {
                    return assets
                } else {
                    return assets.filter {
                        $0.name.lowercased().contains(searchText.lowercased()) ||
                        $0.symbol.lowercased().contains(searchText.lowercased())
                    }
                }
            }
            .assign(to: &$filteredAssets)
    }

    func fetchAssets() {
        guard let url = URL(string: MainURLProvider.assets.urlString) else {
            print("Invalid URL")
            return
        }

        self.isLoading = true
        errorText = ""

        NetworkManager.getData(from: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    if let urlError = error as? URLError {
                        self?.errorText = urlError.userFriendlyMessage()
                    } else {
                        self?.errorText = "An unexpected error occurred. Please try again."
                    }
                }
                self?.isLoading = false
            }, receiveValue: { [weak self] (assetResponse: AssetResponse) in
                self?.assets = assetResponse.data
            })
            .store(in: &cancellables)
    }

    func fetchMarkets() {
        guard let url = URL(string: MainURLProvider.markets.urlString) else {
            print("Invalid URL")
            return
        }

        self.isLoading = true

        NetworkManager.getData(from: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    if let urlError = error as? URLError {
                        self?.errorText = urlError.userFriendlyMessage()
                    } else {
                        self?.errorText = "An unexpected error occurred. Please try again."
                    }
                }

                self?.isLoading = false

            }, receiveValue: { [weak self] (marketResponse: MarketResponse) in
                self?.markets = marketResponse.data
                print(marketResponse.data[2])
                print(marketResponse.data)
            })
            .store(in: &cancellables)
    }
}
