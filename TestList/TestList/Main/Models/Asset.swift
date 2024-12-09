//
//  Asset.swift
//  TestList
//
//  Created by Adrián Juhász on 2024. 12. 09..
//

import Foundation

struct Asset: Identifiable, Decodable {

    var id: String = UUID().uuidString

    let rank: String
    let symbol: String
    let name: String
    let supply: String?
    let maxSupply: String?
    let marketCapUsd: String?
    let volumeUsd24Hr: String?
    let priceUsd: String
    let changePercent24Hr: String?
    let vwap24Hr: String?
    let explorer: String?


    var formattedPrice: String {
        "$\(formatPrice(priceUsd))"
    }

    var formattedPercent: String {
        "\(formatPercent(changePercent24Hr))"
    }

    private func formatPrice(_ price: String) -> String {
       guard let priceValue = Double(price) else { return price }

       let formatter = NumberFormatter()
       formatter.numberStyle = .decimal
       formatter.groupingSeparator = " "
       formatter.maximumFractionDigits = 4
       formatter.minimumFractionDigits = 4

       return formatter.string(from: NSNumber(value: priceValue)) ?? price
   }

    private func formatPercent(_ percent: String?) -> String {
        guard let percentString = percent, let percentValue = Double(percentString) else { return "0.0%" }
        return String(format: "%.1f%%", percentValue)
    }
}
