import SwiftUI

struct ContentView: View {
    
    @State private var bar = 2.0
    @State private var isEditingBar = false
    
    @State private var tempo = 60.0
    @State private var isEditingTempo = false
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("Metronome")
                Spacer();
                Text("Bar");
                HStack{
                    Slider(value: $bar, in: 0...4,step: 1.0, onEditingChanged: {
                        editing in isEditingBar = editing
                    }
                    );
                    Text("\(Int(bar))")
                        .foregroundColor(isEditingBar ? .red : .blue)
                }
                Text("Tempo");
                HStack{
                    Slider(value: $tempo, in: 0...240,step: 1.0, onEditingChanged: {
                        editing in isEditingTempo = editing
                    }
                    )
                    Text("\(Int(tempo))")
                        .foregroundColor(isEditingTempo ? .red : .blue)
                }
                NavigationLink("Show Metronome"){
                    MetronomeView(bar: Int(bar), tempo: Double(tempo));
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }.padding(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

