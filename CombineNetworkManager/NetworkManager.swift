//
//  NetworkManager.swift
//  CombineNetworkManager
//
//  Created by Muneesh Kumar on 26/01/25.
//

import Foundation
import Combine

let baseUrl = "https://jsonplaceholder.typicode.com"


enum EndPoint {
    case posts(limit: Int, start: Int)
    
    var url: String {
        switch self {
        case .posts(let limit, let start):
            return "\(baseUrl)/posts?_limit=\(limit)&_start=\(start)"
        }
    }
}

enum NetworkError: Error {
    case invalidUrl
    case decodingFailed
}

class NetworkManager {
    static let shared = NetworkManager()
    private var cancellable: Set<AnyCancellable> = []
    private init() {
        
    }
    
    func getData<T: Decodable>(url: EndPoint, response: T.Type) -> Future<T, Error> {
        return Future<T, Error> { promise in
            // This is invalid url case
            guard let url = URL(string: url.url) else {
                return promise(.failure(NetworkError.invalidUrl))
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink (receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(error))
                    case .finished:
                        break
                    }
                }, receiveValue: { modelData in
                    promise(.success(modelData))
                })
                .store(in: &self.cancellable)
        }
    }
}
