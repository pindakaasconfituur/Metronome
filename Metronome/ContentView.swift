import SwiftUI
import AVFAudio

struct ContentView: View {
    
    @State private var bar = 2.0
    @State private var isEditingBar = false
    @State private var tempo = 60.0
    @State private var isEditingTempo = false
    @State var timer: Timer?;
    @State private var isPlaying = false
    var metronomeTick: AVAudioPlayer?
    
    init(){
        let path = Bundle.main.path(forResource: "metronome_tick.wav", ofType: nil)!
        let url = URL(fileURLWithPath: path)

        do {
            metronomeTick = try AVAudioPlayer(contentsOf: url)
            metronomeTick?.prepareToPlay() // Preload the audio
        } catch {
            // TODO: catch unhappy flow
        }
    }
    
    var body: some View {
            VStack{
                Text("Metro").font(.system(size: 64)).frame(maxWidth: .infinity, alignment: .leading).fontWeight(.bold)
                Text("Nome").font(.system(size: 64)).frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer();
                
                Text("Bar");
                
                HStack{
                    Slider(value: $bar, in: 0...4,step: 1.0, onEditingChanged: {
                        editing in isEditingBar = editing
                    }
                    ).disabled(true);
                    Text("\(Int(bar))")
                        .foregroundColor(isEditingBar ? .blue : .black)
                }
                Text("Tempo");
                HStack{
                    Slider(value: $tempo, in: 0...240,step: 1.0, onEditingChanged: {
                        editing in isEditingTempo = editing
                    }
                    )
                    Text("\(Int(tempo))")
                        .foregroundColor(isEditingTempo ? .blue : .black)
                }
                
                if(!isPlaying){
                    Button("\t\t") {
                        isPlaying = !isPlaying
                        self.timer = Timer.scheduledTimer(withTimeInterval: 60 / tempo, repeats: true) { _ in
                            DispatchQueue.global(qos: .userInteractive).async {
                                self.metronomeTick?.currentTime = 0 // Rewind to the beginning
                                self.metronomeTick?.play()
                            }
                        }
                        // Invalidate the timer after desired number of bars (if needed)
                        self.timer?.tolerance = 0.01 // Adjust tolerance if necessary for better accuracy
                    }.buttonStyle(.borderedProminent)
                        .tint(.green)
                } else{
                    Button("\t\t"){
                        isPlaying = !isPlaying
                        self.timer?.invalidate();
                        self.metronomeTick?.stop();
                    }.buttonStyle(.borderedProminent)
                        .tint(.red)
                }
                
            }.padding(.all).background(Color(red: 207 / 255, green: 221 / 255, blue: 255 / 255)).foregroundColor(Color.black)
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

