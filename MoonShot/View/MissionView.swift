//
//  MissionView.swift
//  MoonShot
//
//  Created by Sarvad shetty on 1/17/20.
//  Copyright © 2020 Sarvad shetty. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    
    //MARK: - Properties
    let mission: Mission
    let reveal: Bool
    let astronauts: [CrewMember]
    
    //MARK: - Nested struct
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    //MARK: - Init
    init(mission: Mission, astronauts: [Astronaut], reveal: Bool = false) {
        self.mission = mission
        self.reveal = reveal
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    HStack {
                        Text("Lauch date:\(self.mission.formattedLauchDate)")
                            .padding()
                            .isHidden(self.reveal)
                            .font(.footnote)
                        Spacer()
                    }
                    
                    
                    Text(self.mission.description)
                    .padding()
                    
                    Spacer(minLength: 25)
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)){
                            HStack {
                                Image(crewMember.astronaut.id)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    CommanderHighliter(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}

struct MissionView_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}

struct CommanderHighliter: View {
    let role: String
    var foregroundColor: Color = .black
    
    init(_ role: String) {
        self.role = role
        
        if role == "Commander" {
            self.foregroundColor = .red
        }
    }
    
    var body: some View {
        Text(role)
            .foregroundColor(self.foregroundColor)
    }
}
