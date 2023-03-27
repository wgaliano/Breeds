//
//  DogDetailViewModel.swift
//  Breeds
//
//  Created by Walter Galiano on 27/03/23.
//

import Foundation
import Combine

class DogDetailViewModel: ObservableObject {
    @Published var filteredDogs = [DogElement]()
    private var breedIdPath = "/images/search"
    private var observers: Set<AnyCancellable> = []
    
    func getDogsPerBreed(breedId: Int) {
        Network.shared.listDogsPerBreed(path: breedIdPath, breedId: breedId)
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
                self?.filteredDogs = data
            }
            .store(in: &observers)
    }
}
