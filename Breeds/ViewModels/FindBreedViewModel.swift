//
//  FindBreedViewModel.swift
//  Breeds
//
//  Created by Walter Galiano on 27/03/23.
//

import Foundation
import Combine

class FindBreedViewModel: ObservableObject {
    @Published var allBreeds = [Breed]()
    @Published var searchedBreeds: [SearchedBreedElement] = []
    private let breedPath = "/breeds"
    private let searchBreedPath = "/breeds/search"
    private var observers: Set<AnyCancellable> = []
    
    @Published var searchText: String = ""
    
    init() {
        $searchText
            /// debounces the string publisher, such that it delays the process of sending request to remote server.
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 1 {
                    self.searchedBreeds = []
                    return nil
                }
                
                return string
            }) /// prevents sending numerous requests and sends nil if the count of the characters is less than 1.
            /// removes the nil values so the search string does not get passed down to the publisher chain
            .compactMap{ $0 }
            .sink { (_) in
            } receiveValue: { [self] (searchField) in
                print(searchField)
                searchBreedByText(searchText: searchField)
            }.store(in: &observers)
    }
    
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
                self?.allBreeds = data
            }
            .store(in: &observers)
    }
    
    func searchBreedByText(searchText: String) {
        Network.shared.fetchBreedByText(path: searchBreedPath, breedName: searchText)
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
                self?.searchedBreeds = data
            }
            .store(in: &observers)
    }
}
