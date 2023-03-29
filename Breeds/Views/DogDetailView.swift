//
//  DogDetail.swift
//  Breeds
//
//  Created by Walter Galiano on 27/03/23.
//

import SwiftUI

struct DogDetailView: View {
    var breedName: String
    var breedGroup: String
    var breedTemperament: String
    var lifeSpan: String
    var breedId: Int
    @StateObject var vm = DogDetailViewModel()
    @State var backDegree = 90.0
    @State var frontDegree = 0.0
    @State var isFlipped = true

    let width : CGFloat = 320
    let height : CGFloat = 500
    let durationAndDelay : CGFloat = 0.3

    //MARK: Flip Card Function
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                CardBack(width: width, height: height, degree: $backDegree, breedGroup: breedGroup, breedTemperament: breedTemperament, lifeSpan: lifeSpan)
                CardFront(width: width, height: height, degree: $frontDegree, randomDogURL: vm.filteredDogs.first?.url ?? "no url")
            }
            .onTapGesture {
                flipCard ()
            }
            .navigationTitle(breedName)
            .task {
                vm.getDogsPerBreed(breedId: breedId)
            }
        }
    }
    
    
}

struct DogDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DogDetailView(breedName: "Breed name", breedGroup: "Breed group", breedTemperament: "temperament", lifeSpan: "lifestyle", breedId: 1)
    }
}
