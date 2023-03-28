//
//  RandomDogView.swift
//  Breeds
//
//  Created by Walter Galiano on 27/03/23.
//

import SwiftUI

struct TodayView: View {
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
                        .frame(width: 250, height: 250)
                        .scaledToFit()
                        .cornerRadius(32)
                        .padding()
                    }
                }
            }
            .navigationTitle("Dog of the day")
            .task {
                vm.getRandomDog()
            }
            .padding(.vertical, 150)
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}

