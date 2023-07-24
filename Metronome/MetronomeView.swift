//
//  MetronomeView.swift
//  Metronome
//
//  Created by Cem Demirayak on 24/07/2023.
//

import SwiftUI
import AVFoundation

struct MetronomeView: View {
    var bar: Int;
    var tempo: Double;
    var bombSoundEffect: AVAudioPlayer?
    
    init(bar: Int, tempo: Double) {
        self.bar = bar
        self.tempo = tempo
        let path = Bundle.main.path(forResource: "test.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            bombSoundEffect = try AVAudioPlayer(contentsOf: url)
        } catch {
            // couldn't load file :(
        }
        
    }
    
     
    var body: some View {
        Button("Make sound"){
            _ =  Timer.scheduledTimer(withTimeInterval: 60/tempo, repeats: true) { timer in
                print("Make sound")
                bombSoundEffect?.stop();
                bombSoundEffect?.play();
            }
            
        }
        
    }
}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        MetronomeView(bar: 2, tempo: 120)
    }
}
