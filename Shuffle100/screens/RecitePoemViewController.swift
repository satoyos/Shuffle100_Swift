//
//  RecitePoemViewController.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/06/08.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import SnapKit

class RecitePoemViewController: UIViewController {
    var recitePoemView: RecitePoemView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.natsumushi.UIColor
        recitePoemView = RecitePoemView()
        view.addSubview(recitePoemView)
        recitePoemView.initView(title: "序歌")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        recitePoemView.fixLayoutOn(baseView: self.view)
    }
}
