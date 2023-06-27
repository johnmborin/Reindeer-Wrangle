//
//  ContentView.swift
//  Reindeer_Wrangle
//
//  Created by Johnny Borin on 5/15/23.
//
import CoreLocationUI
import SwiftUI
import MapKit

struct SourceView: View {
    @State private var isDestinationActive = false
    @State private var MasterPage = false
    @State private var PlayerPage = false
    var body: some View {
        ZStack{
        Color.red
            .ignoresSafeArea()
        VStack(spacing: 20) {
            
            Spacer()
            VStack(spacing: 0) {
                Text("Reindeer Wrangle")
                    .font(Font.custom("MetroRetroNF", size: 36))
                    .bold()
                    .foregroundColor(.green)
            }
            
            Spacer()
            
            ZStack() {
                Image("Image")
                    .resizable()
                    .scaledToFit()
            }
            
            Spacer()
            
            VStack(spacing: 0) {
                Button(action: {
                    MasterPage = true
                }) {
                    Text("Game Masters")
                }
                .fullScreenCover(isPresented: $MasterPage) {
                                MasterView()
                            }
            }
            
            Spacer()
            
            VStack(spacing: 0) {
                Button(action: {
                    PlayerPage = true
                }) {
                    Text("Hunters")
                }
                .fullScreenCover(isPresented: $PlayerPage) {
                                PlayerView()
                            }
            }
            
            Spacer()
        }
    }
    }
}

struct Team: Identifiable {
    let id = UUID()
    let name: String
}
struct DestinationView: View {
    @State private var name: String = ""
    @State private var pog = false
    @State private var hype = false
    @State private var why = false
    @State private var back = false
    @State private var Team1Members: [String] = []
    @State private var Team2Members: [String] = []
    @State private var Team3Members: [String] = []
    let teams = [
        Team(name: "Team 1"),
        Team(name: "Team 2"),
        Team(name: "Team 3")
    ]
    var body: some View {
        VStack {
            Button(action: {
                back = true
            }) {
                Text("Back")
            }
            .fullScreenCover(isPresented: $back) {
                SourceView()
            }
        }
        Spacer()
        VStack {
            TextField("Name", text: $name)
                .padding()
                .multilineTextAlignment( .center)
            Spacer()
            List(teams) { team in
                Button(action: {
                    addToTeam(name, team.name)
                    
                }) {
                    Text(team.name)
                        .padding()
                }
                
                .fullScreenCover(isPresented: $pog) {
                    
                    Team1View()
                }
                .fullScreenCover(isPresented: $hype) {
                   Team2View(data: name)
                }
                .fullScreenCover(isPresented: $why) {
                   Team3View(data: name)
                }
            }
            
            
            }
           
        }
    
private func addToTeam(_ user: String, _ destinationTeam: String) {
        if destinationTeam == "Team 1" {
            Team1Members.append(user)
            pog = true
        } else if destinationTeam == "Team 2" {
            Team2Members.append(user)
            hype = true
        } else if destinationTeam == "Team 3" {
            Team3Members.append(user)
            why = true
        }
    }
}


struct ContentView: View {
    var body: some View {
        SourceView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Team1View: View {
    @State private var numberOfTeams: Int = 0
        
        var body: some View {
            VStack {
                Stepper(value: $numberOfTeams, in: 0...10, step: 1) {
                    Text("Number of Teams: \(numberOfTeams)")
                }
                
                ScrollView {
                    VStack {
                        ForEach(0..<numberOfTeams, id: \.self) { index in
                            TeamView()
                        }
                    }
                }
            }
            .padding()
        }
    
}

struct Team2View: View {
    var data: String
    var body: some View {
        Text("Team 2")
        Text(data)
    }
}

struct Team3View: View {
   var data: String
    var body: some View {
        Text("Team 3")
        Text(data)
    }
}

struct MasterView: View {
    @State private var back = false
    @State private var santa = false
    @State private var elf = false
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                back = true
            }) {
                Text("Back")
            }
            .fullScreenCover(isPresented: $back) {
                SourceView()
            }
            
            
            
            Button(action: {
                santa = true
            }) {
                Text("Santa")
            }
            .fullScreenCover(isPresented: $santa) {
                SantaView()
            }
            
            Button(action: {
                elf = true
            }) {
                Text("Elf")
            }
            .fullScreenCover(isPresented: $elf) {
                ElfView()
            }
        }
        
    }
}

struct PlayerView: View {
    @State private var back = false
    @State private var code: String = ""
    @State private var submit = false
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                back = true
            }) {
                Text("Back")
            }
            .fullScreenCover(isPresented: $back) {
                SourceView()
            }
            
            TextField("Game Code", text: $code)
                .padding()
                .multilineTextAlignment( .center)
            
            Button(action: {
                if code == "A" {
                    submit = true
                }
            }) {
                Text("Submit")
            }
            .fullScreenCover(isPresented: $submit) {
                Team1View()
            }
        }
        Text("Player")
    }
}

struct SantaView: View {
    @State private var back = false
    @State private var teams = false
    var body: some View {
        VStack {
            Button(action: {
                back = true
            }) {
                Text("Back")
            }
            .fullScreenCover(isPresented: $back) {
                MasterView()
            }
            
            Button(action: {
                teams = true
            }) {
                Text("Create/Edit Teams")
            }
            .fullScreenCover(isPresented: $teams) {
                TeamEditView()
            }
        }
        Text("You are Santa")
    }
}

struct ElfView: View {
    @State private var back = false
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                back = true
            }) {
                Text("Back")
            }
            .fullScreenCover(isPresented: $back) {
                MasterView()
            }
        }
        Text("You are Elf")
    }
}

struct TeamView: View {
    @State private var teamName: String = ""
    @State private var back = false
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                back = true
            }) {
                Text("Back")
            }
            .fullScreenCover(isPresented: $back) {
                TeamEditView()
            }
            
            TextField("New Team", text: $teamName)
                .padding()
                .multilineTextAlignment( .center)
        }
    
            
       
    }
}

struct TeamEditView: View {
    @State private var numberOfTeams: Int = 0
    @State private var edit = false
    var body: some View {
        VStack {
                    Stepper(value: $numberOfTeams, in: 0...10, step: 1) {
                        Text("Number of Teams: \(numberOfTeams)")
                    }
                    
                    ScrollView {
                        VStack {
                            ForEach(0..<numberOfTeams, id: \.self) { index in
                                Button(action: {
                                    // Handle button action for the specific team
                                    edit = true
                                    
                                }) {
                                    Text("Team")
                                }
                                .fullScreenCover(isPresented: $edit) {
                                    TeamView()
                                }
                            }
                            
                            
                        }
                    }
                }
                .padding()
            }
            
            
    }

