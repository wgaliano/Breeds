//
//  RandomDogViewModel.swift
//  Breeds
//
//  Created by Walter Galiano on 27/03/23.
//

import Foundation
import SwiftUI

@MainActor
class RandomDogViewModel: ObservableObject {
    @Published var dogs = [DogElement?]()
    let decoder = JSONDecoder()
    var urlComponents = URLComponents(string: "https://api.thedogapi.com/v1/images/search?")
    
    func getPhotos() async {
        do {
            let url = urlComponents?.url
            let request = URLRequest(url: url!)
            let (data, _) = try await URLSession.shared.data(for: request)
            self.dogs = try decoder.decode([DogElement].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}
