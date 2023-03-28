//
//  DogDetail.swift
//  Breeds
//
//  Created by Walter Galiano on 27/03/23.
//

import SwiftUI

struct DogDetailView: View {
    var breed: Breed
    @StateObject var vm = DogDetailViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    if(!vm.filteredDogs.isEmpty) {
                        ForEach(vm.filteredDogs) { dog in
                            AsyncImage(url: URL(string: dog.url)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 300, height: 300)
                            .scaledToFit()
                            .padding()
                        }
                    }
                }
                Text(breed.temperament ?? "")
                    .padding()
            }
            .navigationTitle(breed.name)
            .task {
                vm.getDogsPerBreed(breedId: breed.id)
            }
            .padding(.vertical, 150)
        }
    }
}

//struct DogDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DogDetailView(breed: B)
//    }
//}
