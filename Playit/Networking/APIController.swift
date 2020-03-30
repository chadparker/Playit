//
//  APIController.swift
//  Playit
//
//  Created by Chad Parker on 2020-03-28.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case otherError(Error)
    case noData
    case decodeFailed(Error)
    case urlProblem
}

final class APIController {

    private let baseUrl = URL(string: "https://www.googleapis.com/youtube/v3/")!

    func ytSearch(_ query: String, completion: @escaping (Result<Search, NetworkError>) -> Void) {
        let searchUrl = baseUrl.appendingPathComponent("search")
        var urlComponents = URLComponents(url: searchUrl, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [
            URLQueryItem(name: "key", value: Keys.youTube),
            URLQueryItem(name: "part", value: "snippet"),
            URLQueryItem(name: "maxResults", value: "5"),
            URLQueryItem(name: "q", value: query),
        ]
        guard let url = urlComponents?.url else {
            completion(.failure(.urlProblem))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completion(.failure(.otherError(error!)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .customISO8601
                let result = try decoder.decode(Search.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodeFailed(error)))
            }
        }.resume()
    }
}
