import SwiftUI
import AVFoundation

struct AudioUnitListNode: View {
    var audioUnitComponent: AVAudioUnitComponent
    var body: some View {
        NavigationLink {
            AudioUnitView(audioUnit: audioUnitComponent)
        } label: {
            AudioUnitRow(audioUnit: audioUnitComponent)
        }
    }
}

struct IdentifiableAudioUnitComponent: Identifiable {
    let id = UUID()
    let component: AVAudioUnitComponent
    
    init(_ component: AVAudioUnitComponent) {
        self.component = component
    }
}

struct AudioUnitList: View {
    var instruments: [IdentifiableAudioUnitComponent]
    var effects: [IdentifiableAudioUnitComponent]
    var midiProcessors: [IdentifiableAudioUnitComponent]
    @State var selectedAudioUnit: UUID?
    
    init(instruments: [AVAudioUnitComponent], effects: [AVAudioUnitComponent], midiProcessors: [AVAudioUnitComponent]) {
        self.instruments = instruments.map { IdentifiableAudioUnitComponent($0) }
        self.effects = effects.map { IdentifiableAudioUnitComponent($0) }
        self.midiProcessors = midiProcessors.map { IdentifiableAudioUnitComponent($0) }
    }
    
    var body: some View {
        List(selection: $selectedAudioUnit) {
            Section(header: Text("Instruments")) {
                ForEach(instruments) { au in
                    AudioUnitListNode(audioUnitComponent: au.component)
                }
            }
            
            Section(header: Text("Effects")) {
                ForEach(effects) { au in
                    AudioUnitListNode(audioUnitComponent: au.component)
                }
            }
            
            Section(header: Text("MIDI Processors")) {
                ForEach(midiProcessors) { au in
                    AudioUnitListNode(audioUnitComponent: au.component)
                }
            }
        }
        .navigationTitle("Installed AUv3 Plug-Ins")
        .navigationBarTitleDisplayMode(.inline)
    }
}
