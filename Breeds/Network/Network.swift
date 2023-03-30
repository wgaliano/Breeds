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
    
    func fetchRandomDog(path: String) -> AnyPublisher<[DogElement], NetworkError> {
        let request = buildRequest(
            method: "GET",
            path: path,
            queryItems: [
                URLQueryItem(
                    name: "limit",
                    value: "\(10)"
                )
            ]
        )
        return perform(request: request, decoder: decodeDogs(from:))
    }
    
    func fetchBreeds(path: String) -> AnyPublisher<[Breed], NetworkError> {
        let request = buildRequest(
            method: "GET",
            path: path,
            queryItems: [
                URLQueryItem(
                    name: "limit",
                    value: "\(180)"
                )
            ]
        )
        return perform(request: request, decoder: decodeBreeds(from:))
    }
    
    func fetchDogsPerBreed(path: String, breedId: Int) -> AnyPublisher<[DogElement], NetworkError> {
        let request = buildRequest(
            method: "GET",
            path: path,
            queryItems: [
                URLQueryItem(
                    name: "breed_ids",
                    value: "\(breedId)"
                )
            ]
        )
        return perform(request: request, decoder: decodeDogs(from:))
    }
    
    func fetchBreedByText(path: String, breedName: String) -> AnyPublisher<[SearchedBreedElement], NetworkError> {
        let request = buildRequest(
            method: "GET",
            path: path,
            queryItems: [
                URLQueryItem(
                    name: "name",
                    value: "\(breedName)"
                )
            ]
        )
        return perform(request: request, decoder: decodeSearchedBreeds(from:))
    }
    
}
