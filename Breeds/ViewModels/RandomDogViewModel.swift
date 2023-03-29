//
//  RandomDogViewModel.swift
//  Breeds
//
//  Created by Walter Galiano on 27/03/23.
//

import Foundation
import Combine

class RandomDogViewModel: ObservableObject {
    @Published var randomDogs = [DogElement]()
    @Published var connectionOff = false
    private var randomDogPath = "/images/search"
    private var observers: Set<AnyCancellable> = []
    
    func getRandomDog() {
        Network.shared.fetchRandomDog(path: randomDogPath)
            .sink {
                completion in
                switch completion {
                case .failure(let error):
                    let error = ResponseHandler.shared.mapError(error)
                    self.connectionOff.toggle()
                    print(error.localizedDescription)
                case .finished:
                    print("\(#function) success")
                }
            } receiveValue: { [weak self] data in
                self?.randomDogs = data
            }
            .store(in: &observers)
    }
}
