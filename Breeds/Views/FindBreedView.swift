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
                if(!vm.breeds.isEmpty) {
                    List(vm.breeds, id: \.id) { breed in
                        NavigationLink {
                            DogDetailView(breed: breed)
                        } label: {
                            Text(breed.name)
                        }
                    }
                }
            }
            .navigationTitle("Breeds")
            .task {
                vm.getBreeds()
            }
        }
    }
}

struct FindBreedView_Previews: PreviewProvider {
    static var previews: some View {
        FindBreedView()
    }
}
