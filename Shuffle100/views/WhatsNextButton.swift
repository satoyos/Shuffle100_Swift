//
//  WhatsNextButton.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/29.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class WhatsNextButton: UIButton {
    func initWithImage(filename: String) {
        let image = UIImage(named: filename)!.reSizeImage(reSize: imageSize())
        setImage(image, for: .normal)
    }
    
    private func imageSize() -> CGSize {
        return CGSize(width: self.frame.size.height, height: self.frame.size.height)
    }
}
