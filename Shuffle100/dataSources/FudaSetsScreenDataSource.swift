//
//  FudaSetsScreenDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/25.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import Then

extension FudaSetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.savedFudaSets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath).then {
            $0.textLabel?.text = "aaa"
        }
        return cell
    }
    
    
}
