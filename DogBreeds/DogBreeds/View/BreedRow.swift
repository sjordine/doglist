//
//  BreedRow.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 24/08/21.
//

import UIKit


/// A cell to represent a dog breed
class BreedRow: UICollectionViewCell {
    
    
    /// Breed name
    var name: String? {
        didSet {
            update()
        }
    }
    
    
    /// Breed image
    var image: UIImage? {
        didSet {
            update()
        }
    }
    
    
    /// Update the cell due to a configuration change
    private func update() {
        OperationQueue.main.addOperation {
            self.setNeedsUpdateConfiguration()
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10.0
    }
    
    override func prepareForReuse() {
        name = ""
        image = nil
    }
    
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var content = BreedConfiguration().updated(for: state)
        content.image = image
        content.name = name
        contentConfiguration = content
    }
    
}
