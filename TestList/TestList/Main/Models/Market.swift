//
//  Market.swift
//  TestList
//
//  Created by Adrián Juhász on 2024. 12. 09..
//

import Foundation

struct Market: Identifiable, Decodable {

    var id: String = UUID().uuidString

    let baseId: String
    let rank: String?
    let baseSymbol: String?
    let exchangeId: String
    let quoteSymbol: String?
    let quoteId: String?
    let priceQuote: String
    let priceUsd: String
    let volumeUsd24Hr: String?
    let percentExchangeVolume: String?
    let tradesCount24Hr: String?
    let updated: Int64?


    var formattedPrice: String {
        "$\(formatPrice(priceUsd))"
    }

    var formattedPercent: String {
        "\(formatPercent(percentExchangeVolume))"
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
