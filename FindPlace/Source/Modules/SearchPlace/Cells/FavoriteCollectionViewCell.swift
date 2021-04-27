//
//  FavoriteCollectionViewCell.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 26.04.2021.
//

import Foundation

import UIKit

final class FavoriteCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var addressLabel: UILabel!
    
    func setAddress(_ string: String) {
        addressLabel.text = string
    }
}
