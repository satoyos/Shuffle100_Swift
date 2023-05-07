//
//  WhatsNextButton.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/29.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SnapKit

class LargeImageAttachedButton: UIButton {
    func initWithImage(filename: String) {
        imageView?.contentMode = .scaleAspectFit
        setImageOf(filename: filename)
    }
    
    func setImageOf(filename: String, with renderingMode: UIImage.RenderingMode = .automatic) {
        let image = UIImage(named: filename)!
//            .reSizeImage(reSize: imageSize)
            .imageWith(newSize: imageSize)
            .withRenderingMode(renderingMode)
        setImage(image, for: .normal)
    }
    
    private func remakeLayoutConstraints() {
        let imageHeiht = bounds.size.height
        titleLabel?.snp.remakeConstraints { make in
            make.leading.equalTo(imageView!.snp.trailing).offset(imageHeiht * 0.5)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame.origin = CGPoint(x: 0, y: 0)
        remakeLayoutConstraints()
    }
    
    private var imageSize: CGSize {
        CGSize(width: self.frame.size.height, height: self.frame.size.height)
    }
    
    
}
