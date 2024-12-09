//
//  AssetResponse.swift
//  TestList
//
//  Created by Adrián Juhász on 2024. 12. 09..
//

import Foundation

struct AssetResponse: Decodable {
    let data: [Asset]
    let timestamp: Int64
}
