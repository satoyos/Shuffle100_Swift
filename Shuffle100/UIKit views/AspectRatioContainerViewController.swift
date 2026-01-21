//
//  AspectRatioContainerViewController.swift
//  Shuffle100
//
//  Created by Claude on 2026/01/18.
//  Copyright © 2026 里 佳史. All rights reserved.
//

import UIKit

class AspectRatioContainerViewController: UIViewController {
  private let contentViewController: UIViewController
  private let containerView = UIView()

  // 縦:横 = 4:3 のアスペクト比
  // つまり 横:縦 = 3:4 なので、幅は高さの 3/4
  private let maxWidthRatio: CGFloat = 3.0 / 4.0

  init(child: UIViewController) {
    self.contentViewController = child
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .black

    view.addSubview(containerView)
    containerView.clipsToBounds = true

    addChild(contentViewController)
    containerView.addSubview(contentViewController.view)
    contentViewController.didMove(toParent: self)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    let bounds = view.bounds
    let containerFrame: CGRect

    if bounds.width > bounds.height {
      // 横長の場合: 幅を制限（縦:横 = 4:3）
      let maxWidth = bounds.height * maxWidthRatio
      let actualWidth = min(bounds.width, maxWidth)
      let x = (bounds.width - actualWidth) / 2
      containerFrame = CGRect(x: x, y: 0, width: actualWidth, height: bounds.height)
    } else {
      // 縦長または正方形の場合: 制限なし
      containerFrame = bounds
    }

    containerView.frame = containerFrame
    contentViewController.view.frame = containerView.bounds
  }

  override var childForStatusBarStyle: UIViewController? {
    return contentViewController
  }

  override var childForStatusBarHidden: UIViewController? {
    return contentViewController
  }

  override var childForHomeIndicatorAutoHidden: UIViewController? {
    return contentViewController
  }

  override var childForScreenEdgesDeferringSystemGestures: UIViewController? {
    return contentViewController
  }
}
