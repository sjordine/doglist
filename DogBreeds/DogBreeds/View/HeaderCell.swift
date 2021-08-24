//
//  HeaderCell.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 24/08/21.
//

import UIKit


/// Breed Group header cell
class HeaderCell: UICollectionViewCell {
    
    /// Creates the defafult cell configuration for the header cell
    /// - Returns: A default, empty configuraton for this cell
    func defaultCell() -> HeaderConfiguration {
        var content = HeaderConfiguration()
        content.title = ""
        return content
    }
    
    override func prepareForReuse() {
        contentConfiguration = defaultCell()
    }
    
}

