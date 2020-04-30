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
        imageView?.contentMode = .scaleAspectFit
        let image = UIImage(named: filename)!.reSizeImage(reSize: imageSize())
        setImage(image, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame.origin = bounds.origin
        titleLabel?.frame = CGRect(
            origin: CGPoint(x: bounds.origin.x + 100, y: bounds.origin.y),
            size: CGSize(width: self.frame.size.width - 100, height: self.frame.size.height))
    }
    
    private func imageSize() -> CGSize {
        return CGSize(width: self.frame.size.height, height: self.frame.size.height)
    }
    
    
}
