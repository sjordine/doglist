//
//  HeaderView.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 24/08/21.
//

import UIKit

class HeaderView: UIView, UIContentView {

    @IBOutlet weak var titleLabel: UILabel!
    
    private var appliedConfiguration: HeaderConfiguration! = HeaderConfiguration()
    private let xibName: String = "HeaderView"
    private var contentView: UIView!
    
    
    var configuration: UIContentConfiguration {
        get { appliedConfiguration }
        set {
            guard let newConfig = newValue as? HeaderConfiguration else { return }
            apply(configuration: newConfig)
        }
    }
    
    
    /// Init the container view with a goiven configuration
    /// - Parameter configuration: cell configuration
    init(configuration: HeaderConfiguration) {
        super.init(frame: .zero)
        xibSetup()
        apply(configuration: configuration)
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
    }
    
    
    /// Apply the given configuration to set this view.
    /// - Parameter configuration: cell configuration
    private func apply(configuration: HeaderConfiguration) {
        appliedConfiguration = configuration
        titleLabel.text  = appliedConfiguration.title
    }
}
