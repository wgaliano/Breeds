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
            VStack {
                if(!vm.randomDogs.isEmpty) {
                    ForEach(vm.randomDogs, id: \.id) { dog in
                        AsyncImage(url: URL(string: dog.url)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                        } placeholder: {
                            ProgressView()
                        }
                        .scaledToFit()
                        .cornerRadius(20)
                        .padding()
                    }
                }
            }
            .navigationTitle("Pick your dog")
            .task {
                vm.getRandomDog()
            }
            .alert(isPresented: $vm.connectionOff) {
                Alert(
                    title: Text("Are you sure you want to delete this?"),
                    message: Text("There is no undo"),
                    primaryButton: .destructive(Text("Try again")) {
                        vm.getRandomDog()
                        vm.connectionOff.toggle()
                    },
                    secondaryButton: .cancel()
                )
            }
            .padding(.vertical, 150)
        }
    }
}



struct RandomDogView_Previews: PreviewProvider {
    static var previews: some View {
        RandomDogView()
    }
}

