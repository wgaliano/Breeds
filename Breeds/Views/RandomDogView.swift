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
                ScrollView {
                    if(!vm.cats.isEmpty) {
                        ForEach(vm.cats, id: \.?.id) { cat in
                            AsyncImage(url: URL(string: cat!.url)) { image in
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
            .navigationTitle("Dog of the day")
            .task {
                await vm.getPhotos()
            }
            .padding()
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}

