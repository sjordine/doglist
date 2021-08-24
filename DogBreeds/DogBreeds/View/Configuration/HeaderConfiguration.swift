//
//  HeaderConfiguration.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 24/08/21.
//

import UIKit

struct HeaderConfiguration: UIContentConfiguration {
    
    var title:String? = nil
    
    
    /// Creates the defafult cell configuration for the header cell
    /// - Returns: A default, empty configuraton for this cell
    static func defaultCell() -> HeaderConfiguration {
        var content = HeaderConfiguration()
        content.title = ""
        return content
    }

    func makeContentView() -> UIView & UIContentView {
        return HeaderView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> HeaderConfiguration {
        guard let _ = state as? UICellConfigurationState else { return self }
        var newConfig =  HeaderConfiguration()
        newConfig.title = title
        return newConfig
    }
    
}
