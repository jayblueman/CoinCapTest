//
//  NetworkManager.swift
//  TestList
//
//  Created by Adrián Juhász on 2024. 12. 09..
//
import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case decodingError
    case unknown(Error) // Generic error case
}

struct NetworkManager {

    static func postData<T: Decodable, U: Encodable>(to url: URL, body: U) -> AnyPublisher<T, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        print("Decoding to type: \(String(describing: T.self))")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }

                print("\(url)'s response: \(httpResponse)")

                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.invalidResponse
                }

                // Try to convert Data to JSON and print it
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                    print("Response JSON: \(json)")
                } else {
                    print("Failed to convert data to JSON")
                }

                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let error = error as? DecodingError {
                    return NetworkError.decodingError
                } else {
                    return NetworkError.unknown(error)
                }
            }
            .eraseToAnyPublisher()
    }

    static func getData<T: Decodable>(from url: URL) -> AnyPublisher<T, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }

                print("\(url)'s response: \(httpResponse)")

                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.invalidResponse
                }

                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let error = error as? DecodingError {
                    return NetworkError.decodingError
                } else {
                    return NetworkError.unknown(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
