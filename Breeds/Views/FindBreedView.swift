//
//  FindBreedView.swift
//  Breeds
//
//  Created by Walter Galiano on 27/03/23.
//

import SwiftUI

struct FindBreedView: View {
    @StateObject var vm = FindBreedViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if(vm.searchText.isEmpty) {
                    if(!vm.allBreeds.isEmpty) {
                        List(vm.allBreeds, id: \.id) { breed in
                            NavigationLink {
                                DogDetailView(breedName: breed.name, breedGroup: breed.breedGroup?.rawValue ?? "Undefined", breedTemperament: breed.temperament ?? "Undefined", lifeSpan: breed.lifeSpan, breedId: breed.id)
                            } label: {
                                Text(breed.name)
                            }
                        }
                    } else {
                        ProgressView()
                    }
                } else {
                    if(!vm.searchedBreeds.isEmpty) {
                        List(vm.searchedBreeds, id: \.id) { searchedBreed in
                            NavigationLink {
                                DogDetailView(breedName: searchedBreed.name, breedGroup: searchedBreed.breedGroup?.rawValue ?? "Undefined", breedTemperament: searchedBreed.temperament ?? "Undefined", lifeSpan: searchedBreed.lifeSpan, breedId: searchedBreed.id)
                            } label: {
                                Text(searchedBreed.name)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Breeds")
            .task {
                vm.getBreeds()
            }
        }
        .searchable(text: $vm.searchText)
    }
}

struct FindBreedView_Previews: PreviewProvider {
    static var previews: some View {
        FindBreedView()
    }
}
