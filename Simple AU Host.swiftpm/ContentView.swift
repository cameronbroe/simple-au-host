import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var audioUnitList: [AudioUnitListNode] = []
    @State var instruments: [AVAudioUnitComponent] = []
    @State var effects: [AVAudioUnitComponent] = []
    @State var midiProcessors: [AVAudioUnitComponent] = []
    
    var body: some View {
        NavigationView {
            AudioUnitList(
                instruments: instruments, 
                effects: effects, 
                midiProcessors: midiProcessors)
            
            Text("Please select an AUv3 Plug-In to load")
        }
        .task {
            instruments = AudioUnitRepository.findInstrumentAudioUnits()
            effects = AudioUnitRepository.findEffectAudioUnits()
            midiProcessors = AudioUnitRepository.findMIDIAudioUnits()
        }
    }
}
