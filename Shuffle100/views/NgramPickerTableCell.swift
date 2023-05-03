//
//  NgramPickerTableCell.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/15.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

private let fullCircleImage = UIImage(named: "full_circle.png")!
private let halfCircleImage = UIImage(named: "half_circle.png")!
private let emptyCircleImage = UIImage(named: "empty_circle.png")!


final class NgramPickerTableCell: UITableViewCell {
    static let selectedImageDic: [PoemsSelectedState: UIImage] = [
        .full: fullCircleImage,
        .partial: halfCircleImage,
        .empry: emptyCircleImage
    ]
    
    var selectedStatus: PoemsSelectedState!

}
