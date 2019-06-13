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
    let headerContainer = UIView()
    let mainContainer = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray // this background is covered by container views
        layoutHeaderContainer()
        layoutMainContainer()
    }
    
    private func layoutHeaderContainer() {
        
        view.addSubview(headerContainer)
        headerContainer.backgroundColor = Color.natsumushi.UIColor
        headerContainer.snp.makeConstraints{(make) -> Void in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
    
    private func layoutMainContainer() {
        view.addSubview(mainContainer)
        mainContainer.backgroundColor = .white
        mainContainer.snp.makeConstraints{(make) -> Void in
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(headerContainer.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }

}
