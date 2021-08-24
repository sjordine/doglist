//
//  HeaderCell.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 24/08/21.
//

import UIKit


/// Breed Group header cell
class HeaderCell: UICollectionViewCell {
    
    func defaultCell() -> HeaderConfiguration {
        var content = HeaderConfiguration()
        content.title = ""
        return content
    }
    
    override func prepareForReuse() {
        contentConfiguration = defaultCell()
    }
    
}

