//
//  ContentView.swift
//  MoonShot
//
//  Created by Sarvad shetty on 1/16/20.
//  Copyright © 2020 Sarvad shetty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("Decode JSON") {
            let input = """
                {
                    "name" : "Sarvad",
                    "address" : {
                                "street" : "K Block",
                                "city" : "Vellore"
                                }
                }
            """
            
            //more code
            struct User: Codable {
                let name: String
                let address: Address
            }
            
            struct Address: Codable {
                let street: String
                let city: String
            }
            
            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address.street)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
