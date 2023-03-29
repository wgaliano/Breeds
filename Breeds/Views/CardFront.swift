//
//  CardFront.swift
//  Breeds
//
//  Created by Walter Galiano on 29/03/23.
//

import SwiftUI

struct CardFront : View {
    let width: CGFloat
    let height: CGFloat
    @Binding var degree: Double
    let randomDogURL: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: width, height: height)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)
            
            AsyncImage(url: URL(string: randomDogURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
                
            } placeholder: {
                ProgressView()
            }
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

//struct CardFront_Previews: PreviewProvider {
//    static var previews: some View {
//        CardFront()
//    }
//}
