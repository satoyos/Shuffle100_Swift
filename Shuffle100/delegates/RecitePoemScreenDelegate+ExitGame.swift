//
//  RecitePoemScreenDelegate+ExitGame.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2022/06/24.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import UIKit

extension RecitePoemScreen: ExitGameProtocol {
  internal func confirmStartingPostMortem() {
    let ac = UIAlertController(title: "感想戦を始めますか？", message: "今の試合と同じ歌を同じ順序で読み上げます", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
    let okAction = UIAlertAction(title: "始める", style: .default) { _ in
      print("++OK、感想戦を始めましょう")
      self.startPostMortemAction?()
    }
    ac.addAction(okAction)
    ac.addAction(cancelAction)
    present(ac, animated: true)
  }
}


