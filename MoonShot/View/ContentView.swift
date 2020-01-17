//
//  ContentView.swift
//  MoonShot
//
//  Created by Sarvad shetty on 1/16/20.
//  Copyright © 2020 Sarvad shetty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var buttonName = "Hide"
    @State private var toggleVal = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination:MissionView(mission: mission, astronauts: self.astronauts, reveal: self.toggleVal)){
                Image(mission.image)
                    .resizable()
//                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(mission.formattedLauchDate)
                    }
                }
            }
        .navigationBarTitle("MoonShot")
            .navigationBarItems(trailing: Button(buttonName){
                self.toggleVal.toggle()
                self.buttonName = self.toggleVal ? "Unhide" : "Hide"
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
