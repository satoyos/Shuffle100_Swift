//
//  FudaViewController.swift
//  WhatsNextScreen
//
//  Created by Yoshifumi Sato on 2020/05/01.
//  Copyright © 2020 Yoshifumi Sato. All rights reserved.
//

import UIKit

class FudaViewController: UIViewController {
    var shimoString = "下の句がここに入る"
    var titleString = "タイトル未定"
    var tatamiView: UIImageView!
    var fudaView: FudaView!
    
    var displayedString: String {
        get {
            guard let fudaView = fudaView else { return "" }
            return fudaView.displayedString
        }
    }
    
    init(shimoString: String, title titleString: String) {
        self.shimoString = shimoString
        self.titleString = titleString

        // クラスの持つ指定イニシャライザを呼び出す
        super.init(nibName: nil, bundle: nil)
    }
    
    // 新しく init を定義した場合に必須
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = titleString
        layoutFudaScreen()
        setDismissButton()
    }

    private func setDismissButton() {
        let dismissButton = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(dismissButtonTapped))
        self.navigationItem.rightBarButtonItem = dismissButton
    }
    
    @objc func dismissButtonTapped() {
        dismiss(animated: true)
    }
    
}
