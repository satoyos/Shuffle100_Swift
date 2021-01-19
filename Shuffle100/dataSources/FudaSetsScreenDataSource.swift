//
//  FudaSetsScreenDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/25.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import Then

extension FudaSetsScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.savedFudaSets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath).then {
            let fudaSet = settings.savedFudaSets[indexPath.row]
            var content = UIListContentConfiguration.valueCell()
            content.text = fudaSet.name
//            $0.textLabel?.text = fudaSet.name
            content.secondaryText = "\(fudaSet.state100.selectedNum)首"
//            $0.detailTextLabel?.text = "\(fudaSet.state100.selectedNum)首"
            $0.contentConfiguration = content
        }
        return cell
    }
    
    
}
