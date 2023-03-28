//
//  FindBreedViewModel.swift
//  Breeds
//
//  Created by Walter Galiano on 27/03/23.
//

import Foundation
import Combine

class FindBreedViewModel: ObservableObject {
    @Published var breeds = [Breed]()
    private let breedPath = "/breeds"
    private var observers: Set<AnyCancellable> = []
    
    func getBreeds() {
        Network.shared.fetchBreeds(path: breedPath)
            .sink {
                completion in
                switch completion {
                case .failure(let error):
                    let error = ResponseHandler.shared.mapError(error)
                    print(error.localizedDescription)
                case .finished:
                    print("\(#function) success")
                }
            } receiveValue: { [weak self] data in
                self?.breeds = data
            }
            .store(in: &observers)
    }
}
