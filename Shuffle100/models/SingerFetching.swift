//
//  SingerFetching.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/01/01.
//  Copyright © 2025 里 佳史. All rights reserved.
//

extension Singers {
    static func fetchSingerFrom(_ settings: Settings) -> Singer {
        guard let singer = Self.getSingerOfID(settings.singerID) else {
            fatalError("Singer of ID \(settings.singerID) is not found.")
        }
        return singer
    }
}
