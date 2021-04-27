//
//  SuggestionTableViewCell.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 26.04.2021.
//

import UIKit

final class SuggestionTableViewCell: UITableViewCell {
    @IBOutlet private weak var addressLabel: UILabel!
    
    func setAddress(_ string: String) {
        addressLabel.text = string
    }
}
