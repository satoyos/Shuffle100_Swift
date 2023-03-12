//
//  FudaScreenLayout.swift
//  WhatsNextScreen
//
//  Created by Yoshifumi Sato on 2020/05/01.
//  Copyright © 2020 Yoshifumi Sato. All rights reserved.
//

import UIKit
import Then

// 札が、superviewのどれくらいを占めたいか。
private let occupyRatio: CGFloat = 2.0 / 3

// 札の各種実測サイズ (単位はmm)
private let fudaHeightMeasured: CGFloat = 73.0
private let fudaWidthMeasured: CGFloat = 53.0
// アスペクト比 (幅/高さ)
private let aspectRatio = fudaWidthMeasured / fudaHeightMeasured

private let fudaFont = UIFont(name: "HiraMinProN-W6", size: 5)
private let fudaFontSizeBase: CGFloat = 17

extension TorifudaScreen: SHDeviceTypeGetter, SHViewSizeGetter {
    internal func layoutFudaScreen() {
        setTatamiBackground()
        setFudaView()
        if deviceType == .phone {
            setFullLinerView()
        }
    }
    
    private func setTatamiBackground() {
        let image = UIImage(named: "tatami_moved.jpg")
        let tatamiView = UIImageView(image: image)
        view.addSubview(tatamiView)
        tatamiView.frame = view.bounds
        self.tatamiView = tatamiView
    }
    
    private func setFudaView() {
        guard let tatamiView = self.tatamiView else { return }
        let height = fudaHeight
        let fudaPower = height / fudaHeightMeasured
        let fudaFrame = CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: CGSize(width: fudaWidthMeasured * fudaPower,
                         height: height))
        let fudaView = FudaView(frame: fudaFrame, withPower: fudaPower, shimoString: shimoString).then {
            $0.center = CGPoint(
                x: view.center.x,
                y: view.center.y + topOffset / 2.0)
        }
        tatamiView.addSubview(fudaView)
        fudaView.accessibilityLabel = "fudaView"
        self.fudaView = fudaView
    }
    
    private func setFullLinerView() {
        guard let fiveStirings = fullLiner else { return }
        let kamiStr = "\(fiveStirings[0]) \(fiveStirings[1]) \(fiveStirings[2])"
        let shimoStr = "\(fiveStirings[3]) \(fiveStirings[4])"
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.95, height: 100)).then {
            $0.text = "\(kamiStr)\n\(shimoStr)"
            $0.textAlignment = .center
            $0.font = fudaFont?.withSize(fudaFontSizeBase)
            $0.textColor = .black
            $0.backgroundColor = UIColor.white.withAlphaComponent(0.4)
            $0.sizeToFit()
            $0.contentOffset = CGPoint(x: 0, y: -5)
            $0.center.x = tatamiView.center.x
            $0.center.y = fullStringsCenterY
            $0.accessibilityLabel = "fullLinersView"
            tatamiView.addSubview($0)
        }
        self.fullLinerView = textView
    }
        
    private var fudaHeight: CGFloat {
        [heightBySuperviewWidth, heightBySuperviewHeight].min()
        ?? 300
    }
    
    private var heightBySuperviewHeight: CGFloat {
//        return (view.frame.size.height - topOffset) * occupyRatio
        (viewHeight - topOffset) * occupyRatio

    }
    
    private var heightBySuperviewWidth: CGFloat {
//        return view.frame.size.width / aspectRatio * occupyRatio
        viewWidth / aspectRatio * occupyRatio
    }
    
    private var topOffset: CGFloat {
        // ステータスバーの高さを取得する
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        // ナビゲーションバーの高さを取得する
        let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
        return statusBarHeight + navigationBarHeight
    }

    private var fullStringsCenterY: CGFloat {
        (fudaView.frame.maxY + tatamiView.frame.maxY) / 2.0
    }
    
}



