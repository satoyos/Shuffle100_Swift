//
//  PoemPickerScreenSearch.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/19.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

extension PoemPickerScreen: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        if text.isEmpty {
            filteredPoems = Poem100.poems
        } else {
            filteredPoems = Poem100.poems.filter {$0.searchText.contains(text)}
        }
        tableView.reloadData()
    }
}
