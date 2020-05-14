//
//  ContentView.swift
//  Summoner Timer
//
//  Created by Lucio Murature on 14/05/2020.
//  Copyright © 2020 Lucio Murature. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
                VStack {
                    Text("Summoner Timer")
                        .font(.largeTitle)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                            .padding(.bottom, 10.0)
                    Summoner(position: "Top", d_spell: "Flash", f_spell: "Teleport")
                    Summoner(position: "Jungle", d_spell: "Flash", f_spell: "Smite")
                    Summoner(position: "Mid", d_spell: "Flash", f_spell: "Ignite")
                    Summoner(position: "AD Carry", d_spell: "Flash", f_spell: "Heal")
                    Summoner(position: "Support", d_spell: "Flash", f_spell: "Exhaust")
                    Text("Made with ♥️ by Lucio Murature")
                        .font(.footnote)
                        .fontWeight(.ultraLight)
            }
        }
    }
}


struct Summoner: View {
    var position: String
    var d_spell: String
    var f_spell: String
    @State var has_d_burnt = false
    @State var has_f_burnt = false
    
    var body: some View {
        VStack {
            Divider()
            Spacer()
            HStack {
                Text(self.position)
                    .font(.title)
                    .fontWeight(.thin)
                Spacer()
                VStack{
                    SummonerSpell(spell: self.d_spell).onTapGesture {
                        printAction(position: self.position, spell: self.d_spell)
                        self.has_d_burnt.toggle()
                    }
                    
                    if self.has_d_burnt {
                        Time(seconds: getSecondsBySpell(spell: self.d_spell))
                    } else { Text("Ready").fontWeight(.light)
                    }
                }
                
                VStack {
                    SummonerSpell(spell: self.f_spell).onTapGesture {
                        printAction(position: self.position, spell: self.f_spell)
                        self.has_f_burnt.toggle()
                    }
                    
                    if self.has_f_burnt {
                        Time(seconds: getSecondsBySpell(spell: self.f_spell))
                    } else {
                        Text("Ready")
                            .fontWeight(.light)
                    }
                }
                
            }
            .padding(.horizontal, 21.0)
            Spacer()
        }
        .padding(.horizontal, 20.0)
    }
}

struct SummonerSpell: View {
    var spell: String
    
    var body: some View {
        HStack {
                Image(self.spell)
                //.cornerRadius(40)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
        }.padding(.all, 10.0)
    }
}

struct Time: View {
    var seconds: Int
    @State var timeRemaining = 300
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text("\(timeRemaining)")
            .fontWeight(.light)
            .onReceive(timer) { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }
            }
        .onAppear {
            self.timeRemaining = self.seconds
        }
    }
}

func getSecondsBySpell(spell: String) -> Int {
    switch spell {
    case "Flash":
        return 300
    case "Ignite":
        return 180
    case "Teleport":
        return 330
    case "Exhaust":
        return 210
    case "Cleanse":
        return 210
    case "Ghost":
        return 180
    case "Barrier":
        return 180
    case "Heal":
        return 240
    case "Smite":
        return 90
    default:
        return 300
    }
}

func printAction(position: String, spell: String) {
    print("\(position) burnt \(spell)")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
