//
//  MarketsResponse.swift
//  TestList
//
//  Created by Adrián Juhász on 2024. 12. 09..
//

import Foundation

struct MarketResponse: Decodable {
    let data: [Market]
    let timestamp: Int64
}
