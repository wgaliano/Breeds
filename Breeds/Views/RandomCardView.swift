//
//  RandomCardView.swift
//  Breeds
//
//  Created by Walter Galiano on 31/03/23.
//

import SwiftUI

struct RandomCardView: View {
    @State private var offset = CGSize.zero
    @State private var color: Color = .black
    var dogImageURL: String
    @StateObject var vm = RandomDogViewModel()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: 320, height: 500)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)
            
                    AsyncImage(url: URL(string: dogImageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 320, height: 500)
                        
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                    .cornerRadius(20)
                    .padding()
        }
        .offset(x: offset.width * 1, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    withAnimation {
                        changeColor(width: offset.width)
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        swipeCard(width: offset.width)
                        changeColor(width: offset.width)
                    }
                }
        )
    }
    
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
        case 150...500:
            offset = CGSize(width: 500, height: 0)
        default:
            offset = .zero
        }
    }
    
    func changeColor(width: CGFloat) {
        switch width {
        case -500...(-130):
            color = .red
        case 130...500:
            color = .green
        default:
            color = .black
        }
    }
    
    
}

struct RandomCardView_Previews: PreviewProvider {
    static var previews: some View {
        RandomCardView(dogImageURL: "")
    }
}
