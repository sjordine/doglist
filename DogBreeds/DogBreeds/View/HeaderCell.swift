//
//  HeaderCell.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 24/08/21.
//

import UIKit


/// Breed Group header cell
class HeaderCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        contentConfiguration = HeaderConfiguration.defaultCell()
    }
    
}

