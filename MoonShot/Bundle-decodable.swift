//
//  Bundle-decodable.swift
//  MoonShot
//
//  Created by Sarvad shetty on 1/16/20.
//  Copyright © 2020 Sarvad shetty. All rights reserved.
//

import Foundation

extension Bundle {
    //get array of astronauts fro json file
    func decode<T: Codable>(_ file:String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("failed to load \(file) in bundle.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}
