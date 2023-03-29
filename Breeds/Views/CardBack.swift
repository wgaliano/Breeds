//
//  CardBack.swift
//  Breeds
//
//  Created by Walter Galiano on 29/03/23.
//

import SwiftUI

struct CardBack : View {
    let width: CGFloat
    let height: CGFloat
    @Binding var degree: Double
    let breedGroup: String
    let breedTemperament: String
    let lifeSpan: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.blue.opacity(0.7), lineWidth: 3)
                .frame(width: width, height: height)

            RoundedRectangle(cornerRadius: 20)
                .fill(.blue.opacity(0.2))
                .frame(width: width, height: height)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)

            RoundedRectangle(cornerRadius: 20)
                .fill(.blue.opacity(0.7))
                .padding()
                .frame(width: width, height: height)

            RoundedRectangle(cornerRadius: 20)
                .stroke(.blue.opacity(0.7), lineWidth: 3)
                .padding()
                .frame(width: width, height: height)
                .overlay(
                    VStack(spacing: 32) {
                        VStack {
                            Text("Breed group")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.white)
                            Text(breedGroup)
                                .foregroundColor(Color.white)
                        }
                        
                        VStack {
                            Text("Temperament")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.white)
                            let array = breedTemperament.components(separatedBy: ",")
                            ForEach(array, id: \.self) { temp in
                                Text(temp)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        VStack {
                            Text("Dog lifespan")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.white)
                            Text(lifeSpan)
                                .foregroundColor(.white)
                        }
                    }
                        .frame(alignment: .leading)
                    .padding()
                )
            
            
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))

    }
}

//struct CardBack_Previews: PreviewProvider {
//    static var previews: some View {
//        CardBack(width: 320, height: 500, degree: 0.0)
//    }
//}
