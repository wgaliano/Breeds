//
//  RandomDogViewModel.swift
//  Breeds
//
//  Created by Walter Galiano on 27/03/23.
//

import Foundation
import Combine

class RandomDogViewModel: ObservableObject {
//    @Published var dogs = [Dog?]()
//    let decoder = JSONDecoder()
//    var urlComponents = URLComponents(string: "https://api.thedogapi.com/v1/images/search")
//
//    func getPhotos() async {
//        do {
//            let url = urlComponents?.url
//            let request = URLRequest(url: url!)
//            let (data, _) = try await URLSession.shared.data(for: request)
//            self.dogs = try decoder.decode([Dog].self, from: data)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
    @Published var randomDogs = [DogElement]()
    private var randomDogPath = "/images/search"
    private var observers: Set<AnyCancellable> = []

    func getRandomDog() {
        Network.shared.fetchRandomDog(path: randomDogPath)
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
                self?.randomDogs = data
            }
            .store(in: &observers)
    }
}
