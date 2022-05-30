import SwiftUI
import AVFoundation
import CoreAudioKit
import UIKit
import AudioKitUI

struct AudioUnitView: View {
    var audioUnit: AVAudioUnitComponent
    @State var auViewController: UIViewController? = nil
    @State var avAudioUnit: AVAudioUnit? = nil
    @State var didError = false
    @State var errorMessage = ""
    @State var showKeyboard = false
    
    var body: some View {
        if let vc = auViewController {
            return VStack {
                AudioUnitViewControllerWrapper(controller: vc)
                    .navigationTitle("\(audioUnit.name) - \(audioUnit.manufacturerName)")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                withAnimation {
                                    showKeyboard.toggle()
                                }
                            } label: {
                                Image(systemName: "gear")
                            }
                        }
                    }
                if showKeyboard {
                    if let midiAu = avAudioUnit as? AVAudioUnitMIDIInstrument {
                        KeyboardViewWrapper(keyboardDelegate: MIDIKeyboardDelegate(audioUnit: midiAu))
                            .transition(.move(edge: .bottom))
                    } else {
                        Text("AUv3 plug-in does not support MIDI events")
                    }
                }
            }
        } else {
            return Text("AudioUnit view controller not ready yet")
                .alert(errorMessage, isPresented: $didError) {}
                .task {
                    do {
                        avAudioUnit = try await AVAudioUnit.instantiate(with: audioUnit.audioComponentDescription)
                        
                        let audioUnit = avAudioUnit?.auAudioUnit
                        let viewController = await audioUnit?.requestViewController()
                        DispatchQueue.main.async {
                            AudioUnitSession.shared.connectAudioUnit(avAudioUnit!)
                            auViewController = viewController
                        }
                    } catch {
                        DispatchQueue.main.async {
                            didError = true
                            errorMessage = error.localizedDescription
                        }
                    }
                }
        }
    }
}
