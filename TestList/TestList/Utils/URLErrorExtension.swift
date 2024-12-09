//
//  URLErrorExtension.swift
//  TestList
//
//  Created by Adrián Juhász on 2024. 12. 09..
//

import Foundation

extension URLError {
    func userFriendlyMessage() -> String {
        switch self.code {
        case .notConnectedToInternet:
            return "You are not connected to the internet. Please check your connection."
        case .timedOut:
            return "The request timed out. Please try again later."
        case .cannotFindHost, .cannotConnectToHost:
            return "Unable to reach the server. Please check the server address."
        case .networkConnectionLost:
            return "Your connection was lost. Please try again."
        default:
            return "A network error occurred. Please try again."
        }
    }
}
