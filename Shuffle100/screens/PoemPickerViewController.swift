//
//  PoemPickerViewController.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/03/08.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import BBBadgeBarButtonItem
import Then

class PoemPickerViewController: UITableViewController {
    var settings: Settings!
    let nadeshiko_color = UIColor(hex: "eebbcb")
    
    var selected_num: Int {
        get {
            return settings.selectedStatus100.selected_num
        }
    }

    init(settings: Settings = Settings()) {
        self.settings = settings
        
        // クラスの持つ指定イニシャライザを呼び出す
        super.init(nibName: nil, bundle: nil)
    }
    
    // 新しく init を定義した場合に必須
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.prompt = "百首読み上げ"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "poems")
        self.navigationItem.title = "歌を選ぶ"
        navigationItem.rightBarButtonItem = saveButtonItem()
    }
    
    @objc func saveButtonTapped(btn: UIBarButtonItem) {
        print("Save Button Tapped!")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Poem100.poems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let poem = Poem100.poems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "poems", for: indexPath).then {
            $0.textLabel?.text = poem.strWithNumberAndLiner()
            $0.textLabel?.font = UIFont(name: "HiraMinProN-W6", size: fontSizeForVerse())
            $0.textLabel?.adjustsFontForContentSizeCategory = true
            $0.backgroundColor = colorFor(poem: poem)
            $0.tag = poem.number
            $0.accessibilityLabel = String(format: "%03d", poem.number)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fontSizeForVerse() * 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settings.selectedStatus100.reverse_in_index(indexPath.row)
        tableView.reloadData()
        return
    }
    
    private func saveButtonItem() -> UIBarButtonItem? {
        let button = UIButton(type: .custom).then {
            $0.setTitle("保存", for: .normal)
            $0.setStandardColor()
            $0.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        }
        let buttonItem = BBBadgeBarButtonItem(customUIButton: button)!.then {
            $0.badgeValue = "\(selected_num)首"
            $0.badgeOriginX = -50
            $0.badgeOriginY = 5
        }
        return buttonItem
    }
    
    private func fontSizeForVerse() -> CGFloat {
        return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body).pointSize
    }
    
    private func colorFor(poem: Poem) -> UIColor {
        if try! settings.selectedStatus100.of_number(poem.number) {
            return nadeshiko_color
        }
        return UIColor.white
    }
}
