//
//  Network.swift
//  Breeds
//
//  Created by Walter Galiano on 27/03/23.
//

import Foundation
import Combine

class Network: NSObject {
    
    /// Create a single instance on Network class
    static let shared = Network()
    
    /// Create a urlSession object, use this to perform requests
    let session: URLSession = URLSession(configuration: .default)
    
    /// URLComponents, use this to create and manipulate endpoints
    var urlComponent = URLComponents(string: "https://api.thedogapi.com/v1")
    
    /// Decoder for JSON `Data`.
    lazy var decoder = JSONDecoder()
    
    /// Encoder for JSON `Data`.
    lazy var encoder = JSONEncoder()
    
    func list(path: String) -> AnyPublisher<[Breed], NetworkError> {
        let request = buildRequest(
            method: "GET",
            path: path
        )
        return perform(request: request, decoder: decodeProducts(from:))
    }
}
