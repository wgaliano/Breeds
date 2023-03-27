//
//  DogDetail.swift
//  Breeds
//
//  Created by Walter Galiano on 27/03/23.
//

import SwiftUI

struct DogDetailView: View {
    var breedId: Int
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
                            .frame(width: 250, height: 250)
                        }
                    }
                }
            }
            .task {
                vm.getDogsPerBreed(breedId: breedId)
            }
            .padding(.vertical, 150)
        }
    }
}

struct DogDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DogDetailView(breedId: 1)
    }
}
