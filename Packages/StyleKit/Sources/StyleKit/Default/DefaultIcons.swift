//
//  DefaultIcons.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import UIKit

public final class DefaultIcons: Icons {

    public var storm: UIImage {
        guard let image = UIImage (systemName: "cloud.bolt.rain.fill") else {
            fatalError("Resource is unavailable")
        }
        return image
    }
}
