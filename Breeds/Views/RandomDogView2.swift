////
////  RandomDogView2.swift
////  Breeds
////
////  Created by Walter Galiano on 29/03/23.
////
//
//import SwiftUI
//
//
//
//struct RandomDogView2: View {
//    //MARK: Variables
//    @State var backDegree = 0.0
//    @State var frontDegree = -90.0
//    @State var isFlipped = false
//    @StateObject var vm = RandomDogViewModel()
//
//    let width : CGFloat = 320
//    let height : CGFloat = 500
//    let durationAndDelay : CGFloat = 0.3
//
//    //MARK: Flip Card Function
//    func flipCard () {
//        isFlipped = !isFlipped
//        if isFlipped {
//            withAnimation(.linear(duration: durationAndDelay)) {
//                backDegree = 90
//            }
//            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
//                frontDegree = 0
//            }
//        } else {
//            withAnimation(.linear(duration: durationAndDelay)) {
//                frontDegree = -90
//            }
//            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
//                backDegree = 0
//            }
//        }
//    }
//    //MARK: View Body
//    var body: some View {
//        ZStack {
//            CardFront(width: width, height: height, degree: $frontDegree, randomDogURL: vm.randomDogs.first?.url ?? "no url")
//            CardBack(width: width, height: height, degree: $backDegree, breedName: vm.randomDogs.first.)
//        }
//        .onTapGesture {
//            flipCard ()
//        }
//        .task {
//            vm.getRandomDog()
//        }
//    }
//}
//
//struct RandomDogView2_Previews: PreviewProvider {
//    static var previews: some View {
//        RandomDogView2()
//    }
//}
