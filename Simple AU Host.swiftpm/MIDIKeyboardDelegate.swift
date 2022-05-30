import AudioKit
import AudioKitUI
import AVFoundation
import CoreMIDI
import AudioUnit

enum MIDIKeyboardDelegateError: Error {
    case notAMidiInstrument
}

class MIDIKeyboardDelegate: KeyboardDelegate {
    var audioUnit: AVAudioUnitMIDIInstrument
    
    init(audioUnit: AVAudioUnitMIDIInstrument) {
        self.audioUnit = audioUnit 
    }
    
    func noteOn(note: MIDINoteNumber) {
        audioUnit.startNote(note, withVelocity: 127, onChannel: 1)
    }
    
    func noteOff(note: MIDINoteNumber) {
        audioUnit.stopNote(note, onChannel: 1)
    }
}
