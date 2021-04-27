//
//  SearchPlaceViewController.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import UIKit

struct SearchViewState {
    let errorMessage: String?
    let favorites: PlacesDataSource?
    let suggestions: PlacesDataSource?
}

final class SearchPlaceViewController: UIViewController {
    
    var viewModel: SearchPlaceViewModelProtocol?
    @IBOutlet private weak var suggestionsTableView: UITableView!
    @IBOutlet private weak var favoritesCollectionView: UICollectionView!
    @IBOutlet private weak var searchTextField: UITextField!
    
    private struct Constants {
        static let suggestionCellIdetifier = "SuggestionCell"
        static let favoriteCellIdentifier = "FavoriteCell"
    }
    
    private var currentState: SearchViewState?
    
}

private extension SearchPlaceViewController {
    func render(state: SearchViewState) {
        currentState = state
        suggestionsTableView.reloadData()
        favoritesCollectionView.reloadData()
    }
}

extension SearchPlaceViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewModel?.startSession()
    }
    
    @IBAction func textChanged(textField: UITextField) {
        viewModel?.getList(for: textField.text ?? "") { [weak self] result in
            self?.render(state: result)
        }
    }
}

extension SearchPlaceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentState?.suggestions?.numberOfItems(at: 0) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.suggestionCellIdetifier, for: indexPath)
        
        if let suggestionCell = cell as? SuggestionTableViewCell {
            if let dataSource = currentState?.suggestions {
                suggestionCell.setAddress(dataSource.item(at: indexPath.row))
            }
        }
        
        return cell
    }
}

extension SearchPlaceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentState?.favorites?.numberOfItems(at: 0) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.favoriteCellIdentifier, for: indexPath)
        
        if let favoriteCell = cell as? FavoriteCollectionViewCell {
            if let dataSource = currentState?.favorites {
                favoriteCell.setAddress(dataSource.item(at: indexPath.item))
            }
        }
        
        return cell
    }
    
}
