//
//  RandomDogView.swift
//  Breeds
//
//  Created by Walter Galiano on 27/03/23.
//

import SwiftUI

struct RandomDogView: View {
    @StateObject var vm = RandomDogViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .frame(width: 320, height: 500)
                    .shadow(color: .gray, radius: 2, x: 0, y: 0)
                
                if(!vm.randomDogs.isEmpty) {
                    ForEach(vm.randomDogs, id: \.id) { dog in
                        RandomCardView(dogImageURL: dog.url)
                    }
                }
            }
            .navigationTitle("Pick your dog")
            .task {
                vm.getRandomDog()
            }
        }
    }
}



struct RandomDogView_Previews: PreviewProvider {
    static var previews: some View {
        RandomDogView()
    }
}

