//
//  SearchedBreedElement.swift
//  Breeds
//
//  Created by Walter Galiano on 29/03/23.
//

import Foundation

// MARK: - SearchedBreedElement
//struct SearchedBreedElement: Codable {
//    let weight, height: Eight
//    let id: Int
//    let name, bredFor, breedGroup, lifeSpan: String
//    let temperament, referenceImageID: String
//
//    enum CodingKeys: String, CodingKey {
//        case weight, height, id, name
//        case bredFor = "bred_for"
//        case breedGroup = "breed_group"
//        case lifeSpan = "life_span"
//        case temperament
//        case referenceImageID = "reference_image_id"
//    }
//}

// MARK: - SearchedBreedElement
struct SearchedBreedElement: Codable {
    let weight, height: Eight
    let id: Int
    let name: String
    let bredFor: String?
    let breedGroup: BreedGroup?
    let lifeSpan: String
    let temperament, origin, referenceImageID, countryCode: String?
    let history: String?

    enum CodingKeys: String, CodingKey {
        case weight, height, id, name
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperament, origin
        case referenceImageID = "reference_image_id"
        case countryCode = "country_code"
        case history
    }
}

//enum BreedGroup: String, Codable {
//    case nonSporting = "Non-Sporting"
//    case terrier = "Terrier"
//    case toy = "Toy"
//    case working = "Working"
//}

//// MARK: - Eight
//struct Eight: Codable {
//    let imperial, metric: String
//}

typealias SearchedBreed = [SearchedBreedElement]
