//
//  HelpDetailViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/06/26.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class HelpDetailViewController: UIViewController {
    var helpTitle: String!
    var htmlFileName: String!
    
    init(title: String, htmlFileName: String) {
        self.helpTitle = title
        self.htmlFileName = htmlFileName

        // クラスの持つ指定イニシャライザを呼び出す
        super.init(nibName: nil, bundle: nil)
    }
    
    // 新しく init を定義した場合に必須
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = helpTitle
    }

}
