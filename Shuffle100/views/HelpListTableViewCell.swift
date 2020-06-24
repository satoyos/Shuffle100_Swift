//
//  HelpListTableViewCell.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/06/21.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class HelpListTableViewCell: UITableViewCell {
    private var htmlFileName: String!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with dataSource: HelpListDataSource) {
        self.textLabel?.text = dataSource.name
        switch dataSource.type {
        case .html:
            self.htmlFileName = dataSource.fileName
            self.accessoryType = .disclosureIndicator
        case .value1:
            self.detailTextLabel?.text = dataSource.detail
        }
    }

}
