//
//  BreedRow.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 24/08/21.
//

import UIKit


/// A cell to represent a dog breed
class BreedRow: UICollectionViewCell {
    
    /// Creates the defafult cell configuration for the breed cell
    /// - Returns: A default, empty configuraton for this cell
    func defaultCell() -> BreedConfiguration {
        var content = BreedConfiguration()
        content.image = nil
        content.name = ""
        return content
    }
    
    override func prepareForReuse() {
        contentConfiguration = defaultCell()
    }
  
}
