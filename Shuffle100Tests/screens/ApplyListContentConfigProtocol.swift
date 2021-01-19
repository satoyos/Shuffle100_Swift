//
//  ApplyListContentConfigProtocol.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2021/01/19.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

protocol ApplyListContentConfiguration {
    func listContentConfig(of cell: UITableViewCell) -> UIListContentConfiguration
}

extension ApplyListContentConfiguration where Self: XCTestCase {
    func listContentConfig(of cell: UITableViewCell) -> UIListContentConfiguration {
        guard let config = cell.contentConfiguration as? UIListContentConfiguration else {
            XCTFail("ContentConfiguration of the cell should be UIListContentConfiguration!")
            return UIListContentConfiguration.cell()
        }
        return config
    }
}
