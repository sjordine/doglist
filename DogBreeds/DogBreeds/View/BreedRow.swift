//
//  BreedRow.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 24/08/21.
//

import UIKit


/// A cell to represent a dog breed
class BreedRow: UICollectionViewCell {
    
    override func prepareForReuse() {
        contentConfiguration = BreedConfiguration.defaultCell()
    }
  
}
