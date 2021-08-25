//
//  BreedView.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 24/08/21.
//

import UIKit


/// Breed row content view
class BreedView:UIView, UIContentView {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var appliedConfiguration: BreedConfiguration! = BreedConfiguration()
    private let xibName: String = "BreedView"
    private let placeholderImageName = "dog"
    private var contentView: UIView!
    
    
    var configuration: UIContentConfiguration {
        get { appliedConfiguration }
        set {
            guard let newConfig = newValue as? BreedConfiguration else { return }
            apply(configuration: newConfig)
        }
    }
    
    
    /// Init the container view with a goiven configuration
    /// - Parameter configuration: cell configuration
    init(configuration: BreedConfiguration) {
        super.init(frame: .zero)
        xibSetup()
        self.configuration = configuration
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func xibSetup() {
        loadXib(targetView: &contentView, xibName: xibName)
        self.contentView.clipsToBounds = true
        self.roundCorners(.allCorners, radius: 5.0)
    }
    
    
    /// Apply the given configuration to set this view.
    /// - Parameter configuration: cell configuration
    private func apply(configuration: BreedConfiguration) {
       // guard appliedConfiguration != configuration else { return }
        appliedConfiguration = configuration
        titleLabel.text  = appliedConfiguration.name
        
        image.image = appliedConfiguration.image ?? UIImage(named: placeholderImageName)
    }
    
}
