//
//  XCUIElement+GentleSwipe.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2022/10/24.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import Foundation
import XCTest

extension XCUIElement
{
    enum direction : Int {
        case Up, Down, Left, Right
    }

    func gentleSwipe(_ direction : direction,
                     adjustment: CGFloat = 0.25) {
        let half : CGFloat = 0.5
        let pressDuration : TimeInterval = 0.05

        let lessThanHalf = half - adjustment
        let moreThanHalf = half + adjustment

        let centre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: half))
        let aboveCentre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: lessThanHalf))
        let belowCentre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: moreThanHalf))
        let leftOfCentre = self.coordinate(withNormalizedOffset: CGVector(dx: lessThanHalf, dy: half))
        let rightOfCentre = self.coordinate(withNormalizedOffset: CGVector(dx: moreThanHalf, dy: half))

        switch direction {
        case .Up:
            centre.press(forDuration: pressDuration, thenDragTo: aboveCentre)
            break
        case .Down:
            centre.press(forDuration: pressDuration, thenDragTo: belowCentre)
            break
        case .Left:
            centre.press(forDuration: pressDuration, thenDragTo: leftOfCentre)
            break
        case .Right:
            centre.press(forDuration: pressDuration, thenDragTo: rightOfCentre)
            break
        }
    }
}
