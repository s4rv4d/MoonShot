//
//  ContentView.swift
//  MoonShot
//
//  Created by Sarvad shetty on 1/16/20.
//  Copyright © 2020 Sarvad shetty. All rights reserved.
//

import SwiftUI

struct CustomText: View {
    var text: String
    
    init(_ text: String){
        print("Creating a custom Text")
        self.text = text
    }
    
    var body: some View {
        Text(text)
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 10){
                ForEach(0..<100){
                    CustomText("\($0)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
