//
//  Measure.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 23/08/21.
//
import Foundation


/// Defines a dog breed measure (weight, size) on both imperical and metric units
struct Measure: Codable, Hashable {
    var imperial: String
    var metric: String
}
