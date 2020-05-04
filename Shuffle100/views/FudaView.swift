//
//  FudaView.swift
//  WhatsNextScreen
//
//  Created by Yoshifumi Sato on 2020/05/03.
//  Copyright © 2020 Yoshifumi Sato. All rights reserved.
//

import UIKit
import Then

// 札の各種実測サイズ (単位はmm)
private let greenOffsetMeasured: CGFloat = 2.0
// 文字のフォント
private let fudaFont = UIFont(name: "HiraMinProN-W6", size: 5)
private let fudaFontSizeBase: CGFloat = 11


class FudaView: UIImageView {
    var fudaPower: CGFloat
    var shimoString: String
    var whiteBackView: UIView!
    var labels15 = [UILabel]()

    init(frame: CGRect, withPower fudaPower: CGFloat = 0.0, shimoString: String) {
        self.fudaPower = fudaPower
        self.shimoString = shimoString
        super.init(frame: frame)
        let image = UIImage(named: "washi_darkgreen 001.jpg")
        self.image = image
        setSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubViews() {
        setWhiteBackView()
        setLabels15()
    }
    
    private func setWhiteBackView() {
        let fudaHeight = self.frame.height
        let fudaWidth = self.frame.width
        let offset = greenOffsetMeasured * fudaPower
        let whiteBackView = UIView(frame: CGRect(
            x: offset, y: offset,
            width: fudaWidth - 2 * offset,
            height: fudaHeight - 2 * offset)).then {
                $0.backgroundColor = UIColor(hex: "FFF7E5")
            self.addSubview($0)
        }
        self.whiteBackView = whiteBackView
    }
    
    private func setLabels15() {
        let strArray = (shimoString + "  ").splitInto(1)
        for idx in 0..<15 {
            let label = UILabel().then {
                $0.text = strArray[idx]
                $0.font = fudaFont?.withSize(fudaFontSize())
                $0.textAlignment = .center
                $0.frame = CGRect(origin: labelOriginOf(idx),
                                  size: labelSize())
                $0.accessibilityLabel = "fudaChar_\(idx)"
                $0.textColor = .black
                self.addSubview($0)
            }
            self.labels15.append(label)
        }
    }
    
    private func fudaFontSize() -> CGFloat {
        return fudaFontSizeBase * fudaPower
    }
    
    private func labelOriginOf(_ index: Int) -> CGPoint{
        return CGPoint(x: labelOriginZero().x + labelSize().width * CGFloat(columnNumberOf(labelIndex: index )),
                       y: labelOriginZero().y + labelSize().height * CGFloat((index % 5)))
    }
    
    private func columnNumberOf(labelIndex: Int) -> Int {
        switch labelIndex {
        case 0..<5:
            return 2
        case 5..<10:
            return 1
        default:
            return 0
        }
    }
    
    private func labelSize() -> CGSize {
        return CGSize(width: whiteBackView.frame.width / 3,
                      height: whiteBackView.frame.height / 5)
    }
    
    private func labelOriginZero() -> CGPoint {
        return CGPoint(x: greenOffsetMeasured * fudaPower,
                       y: greenOffsetMeasured * fudaPower)
    }

}
