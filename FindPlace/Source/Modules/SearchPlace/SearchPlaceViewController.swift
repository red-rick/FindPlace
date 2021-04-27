//
//  SearchPlaceViewController.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import UIKit

final class SearchPlaceViewController: UIViewController {
    
    var viewModel: SearchPlaceViewModelProtocol?
    @IBOutlet private weak var suggestionsTableView: UITableView!
    @IBOutlet private weak var favoritesCollectionView: UICollectionView!
    @IBOutlet private weak var searchTextField: UITextField!
    
    private var currentState: SearchViewState?
    
}

extension SearchPlaceViewController: ViewProtocol {
    func render<SearchViewState>(state: SearchViewState) {
        suggestionsTableView.reloadData()
        favoritesCollectionView.reloadData()
    }
}

extension SearchPlaceViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
}
