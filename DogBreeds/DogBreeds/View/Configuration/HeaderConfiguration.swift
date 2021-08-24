//
//  HeaderConfiguration.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 24/08/21.
//

import UIKit

struct HeaderConfiguration: UIContentConfiguration, Hashable {

    func makeContentView() -> UIView & UIContentView {
        return HeaderView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> HeaderConfiguration {
        guard let state = state as? UICellConfigurationState else { return self }
        var newConfig =  HeaderConfiguration()
        newConfig.title = title
        return newConfig
    }
    
    var title:String? = nil
}
