//
//  PoemPickerViewController.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/03/08.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

class PoemPickerViewController: UITableViewController {
    var settings: Settings!
    let nadeshiko_color = UIColor(hex: "eebbcb")

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
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Poem100.poems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "poems", for: indexPath)
        let poem = Poem100.poems[indexPath.row]
        cell.textLabel?.text = poem.strWithNumberAndLiner()
        cell.textLabel?.font = UIFont(name: "HiraMinProN-W6", size: fontSizeForVerse())
        cell.textLabel?.adjustsFontForContentSizeCategory = true
        cell.backgroundColor = colorFor(poem: poem)
        cell.tag = poem.number
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fontSizeForVerse() * 3
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
