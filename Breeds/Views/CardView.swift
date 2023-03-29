//
//  CardView.swift
//  Breeds
//
//  Created by Walter Galiano on 29/03/23.
//

import SwiftUI

//struct CardView: View {
//    var isFaceUp: Bool
//    var imageName = "Cake1"
//    var axis:(CGFloat,CGFloat,CGFloat) = (1.0,0.0,0.0)
//    
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 20)
//                .fill(Color.orange.opacity(isFaceUp ? 0.5 : 1.0))
//            if isFaceUp {
//                Image(from: imageName as! Decoder)
//                    //.resizable()
//                    .scaledToFit()
//                    .clipped()
//                    .cornerRadius(15.0)
//                    .padding(10)
//            }
//        }
//        .rotation3DEffect(
//            Angle.degrees(isFaceUp ? 0: 180),
//            axis: axis
//        )
//    }
//}
//
//
//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(isFaceUp: true)
//    }
//}
