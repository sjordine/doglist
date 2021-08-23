//
//  DogBreed.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 23/08/21.
//

import Foundation


/// Defines  dog breeds characteristics
struct DogBreed: Codable, Identifiable, Hashable {
   
    static func == (lhs: DogBreed, rhs: DogBreed) -> Bool {
        lhs.id == rhs.id
    }
    

    enum CodingKeys: String, CodingKey {
        case bredFor = "bred_for"
        case group = "breed_group"
        case height
        case id = "id"
        case lifeSpan = "life_span"
        case name
        case origin
        case referenceImageId = "reference_image_id"
        case temperament
        case weight
        case image
    }
    
    var id: Int
    var name: String
    var origin: String?
    var bredFor: String?
    var group: String?
    var temperament: String?
    var referenceImageId: String
    var height:Measure
    var weight: Measure
    var lifeSpan: String
    var image: DogImage
    
}
