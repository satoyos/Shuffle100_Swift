//
//  StoreManager.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/02/14.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation

protocol Storable {
    func data(forKey: String) -> Data?
    func set(_ data :Any?, forKey: String)
}

// テスト用スタブのため
extension UserDefaults: Storable{}

// 責務：データの永続化
struct StoreManager {

    let store: Storable

    init(store: Storable = UserDefaults.standard) {
        self.store = store
    }

    func save<T: Codable>(value: T, key: String) throws {
        do {
            let encodedData = try JSONEncoder().encode(value)
            store.set(encodedData, forKey: key)
        } catch let error {
            throw error
        }
    }

    func load<T: Codable>(key: String) -> T? {
        guard let data = store.data(forKey: key) else { return nil }
        do {
            let decode = try JSONDecoder().decode(T.self, from: data)
            return decode
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
