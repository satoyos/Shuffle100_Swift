//
//  DigitsPickerScreen10DataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2023/05/16.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import UIKit
import Then

extension DigitsPickerScreen10: UITableViewDataSource, TableViewHandler, PoemSelectedStateHandler {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else { return 0 }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as! SelectByGroupCell
        var config = UIListContentConfiguration.cell()
        config.text = (indexPath.row+1).description
        cell.contentConfiguration = config
        return cell
    }
    
    
}
