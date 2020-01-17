//
//  AstronautView.swift
//  MoonShot
//
//  Created by Sarvad shetty on 1/17/20.
//  Copyright © 2020 Sarvad shetty. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    
    //MARK: - Properties
    let astronaut: Astronaut
    let ms: [Mission]
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        
        var ms = [Mission]()
        
        for mission in missions {
            for member in mission.crew {
                if member.name == astronaut.id {
                    ms.append(mission)
                }
            }
        }
        self.ms = ms
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                    .resizable()
                    .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text(self.astronaut.description)
                    .padding()
                    .layoutPriority(1)
                    
                    Spacer()
                    
                    HStack {
                        Text("Missions")
                            .font(.headline)
                        Spacer()
                    }.padding(.horizontal)
                    
                    ForEach(self.ms, id: \.id) { m in
                        HStack {
                            Image(m.image)
                            .resizable()
                            .scaledToFit()
                                .frame(width: 44, height: 44)
                            
                            Text(m.displayName)
                                .font(.headline)
                            Spacer()
                        }.padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
