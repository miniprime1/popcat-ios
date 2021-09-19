//
//  ContentView.swift
//  Shared
//
//  Created by 남규민 on 2021/09/19.
//

import SwiftUI
import AVFoundation

var player: AVAudioPlayer?

struct ContentView: View {
    @State var popcat_png = "popcat_closemouth_png"
    @State var counter = 0
    var body: some View {
        VStack {
            Text("\(counter)").bold()
            Image(popcat_png).resizable().scaledToFit().frame(width: 400*3/10, height: 570*3/10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Button(action: pop, label: {
                Text("Pop!").font(.largeTitle).bold()
            })
        }
    }
    
    func open() {
        popcat_png = "popcat_openmouth_png"
    }
    
    func close() {
        popcat_png = "popcat_closemouth_png"
    }
    
    func playSound() {
        let url = Bundle.main.path(forResource: "popcat_sound", ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let url = url else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))
            
            guard let player = player else {
                return
            }
            
            player.play()
        } catch {
            print(error)
        }
    }
    
    func pop() {
        counter = counter + 1
        open()
        playSound()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            close()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
