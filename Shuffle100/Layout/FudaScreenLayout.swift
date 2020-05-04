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

extension FudaViewController {
    internal func layoutFudaScreen() {
        setTatamiBackground()
        setFudaView()
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
        let height = fudaHeight()
        let fudaPower = height / fudaHeightMeasured
        let fudaFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: fudaWidthMeasured * fudaPower, height: height) )
        let fudaView = FudaView(frame: fudaFrame, withPower: fudaPower, shimoString: shimoString).then {
            $0.center = CGPoint(x: view.center.x, y: view.center.y + topOffset() / 2.0)
        }
        tatamiView.addSubview(fudaView)
        self.fudaView = fudaView
    }
        
    private func fudaHeight() -> CGFloat {
        return [heightBySuperviewWidth(), heightBySuperviewHeight()].min() ?? 300
    }
    
    private func heightBySuperviewHeight() -> CGFloat {
        return (view.frame.size.height - topOffset()) * occupyRatio
    }
    
    private func heightBySuperviewWidth() -> CGFloat {
        return view.frame.size.width / aspectRatio * occupyRatio
    }
    
    private func topOffset() -> CGFloat {
        // ステータスバーの高さを取得する
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        // ナビゲーションバーの高さを取得する
        let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
        return statusBarHeight + navigationBarHeight
    }
    
}



