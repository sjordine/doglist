//
//  HeaderCell.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 24/08/21.
//

import UIKit


/// Breed Group header cell
class HeaderCell: UICollectionViewCell {
    
    /// Header title
    @IBOutlet weak var titleLabel: UILabel!
    
    /// Breed name
    var title: String? {
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
    
    override func prepareForReuse() {
        title = ""
    }
    
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var content = HeaderConfiguration().updated(for: state)
        content.title = title
        contentConfiguration = content
    }
    
}

