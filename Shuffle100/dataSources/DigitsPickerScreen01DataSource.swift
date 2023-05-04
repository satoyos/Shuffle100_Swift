//
//  DigitsPickerScreen01DataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2023/05/03.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import UIKit


// [
//    [10, 20, ..., 100],
//    [ 1, 11, ...,  91],
//    [ 2, 12, ...,  92],
//    ...,
//    [ 9, 19, ...,  99]
// ]
fileprivate func calcCardNumbers() -> [[Int]] {
    var result = [[Int]]()
    for i in (1...10) {
        var row = [Int]()
        for j in (0..<10) {
            row.append(i + 10*j)
        }
        result.append(row)
    }
    let lastLine = result.removeLast()
    result.insert(lastLine, at: 0)
    return result
}

fileprivate let cardNumbers = calcCardNumbers()

extension DigitsPickerScreen01: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else { return 0 }
        return cardNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)
        return cell
    }
    
    
}
