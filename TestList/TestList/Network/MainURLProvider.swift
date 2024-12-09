//
//  MainURLProvider.swift
//  TestList
//
//  Created by Adrián Juhász on 2024. 12. 09..
//

import Foundation

protocol URLProvider {
    var baseURLString: String { get }
    var path: String { get }

    var urlString: String { get }
}

enum MainURLProvider: URLProvider {
    case assets
    case markets

    var baseURLString: String {
        return "https://api.coincap.io/v2/"
    }

    var path: String {
        switch self {
        case .markets:
            return "markets"
        case .assets:
            return "assets"

        }
    }

    var urlString: String {
        return baseURLString + path
    }
}

//https://assets.coincap.io/assets/icons/btc@2x.png

enum AssetURLProvider: URLProvider {
    case icon(String)

    var baseURLString: String {
        return "https://assets.coincap.io/assets/"
    }

    var path: String {
        switch self {
        case .icon(let name):
            return "icons/\(name.lowercased())@2x.png"
        }
    }

    var urlString: String {
        return baseURLString + path
    }
}
