//
//  DogImage.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 23/08/21.
//

import Foundation

/// Defines dog image metadata
struct DogImage: Codable, Identifiable, Hashable {
    var id: String
    var height: Int
    var width: Int
    var url: String
}

