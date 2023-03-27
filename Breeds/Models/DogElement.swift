//
//  DogElement.swift
//  Breeds
//
//  Created by Walter Galiano on 27/03/23.
//

import Foundation

// MARK: - DogElement
struct DogElement: Identifiable, Codable {
    let id: String
    let url: String
    let width, height: Int
}

typealias Dog = [DogElement]
