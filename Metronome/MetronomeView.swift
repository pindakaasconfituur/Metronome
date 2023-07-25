import SwiftUI
import AVFoundation

struct MetronomeView: View {
    var tempo: Double
    var metronomeTick: AVAudioPlayer?
    var gauge: Int = 0;
    
    @State var timer: Timer?;

    init(tempo: Double) {
        self.tempo = tempo
        let path = Bundle.main.path(forResource: "test.wav", ofType: nil)!
        let url = URL(fileURLWithPath: path)

        do {
            metronomeTick = try AVAudioPlayer(contentsOf: url)
            metronomeTick?.prepareToPlay() // Preload the audio
        } catch {

        }
        
    }
    
    func playSound(){
        self.timer = Timer.scheduledTimer(withTimeInterval: 60 / tempo, repeats: true) { _ in
            DispatchQueue.global(qos: .userInteractive).async {
                self.metronomeTick?.currentTime = 0 // Rewind to the beginning
                self.metronomeTick?.play()
            }
        }
        // Invalidate the timer after desired number of bars (if needed)
        self.timer?.tolerance = 0.01 // Adjust tolerance if necessary for better accuracy
    }

    var body: some View {
        
        VStack{
            NavigationStack{
                HStack{
                    Button("Make sound") {
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
                    Button("Stop"){
                        self.timer?.invalidate();
                        self.metronomeTick?.stop();
                    }.buttonStyle(.borderedProminent)
                        .tint(.red)
                }
                Spacer()
                
            }
        }.padding(.all).background(Color(red: 207 / 255, green: 221 / 255, blue: 255 / 255))
    }
}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        MetronomeView(tempo: 120)
    }
}

