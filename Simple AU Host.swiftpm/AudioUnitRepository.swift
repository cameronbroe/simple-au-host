import AudioUnit
import AVFoundation

class AudioUnitRepository {
    private static func findAudioUnits(byType: OSType = 0, bySubType: OSType = 0) -> [AVAudioUnitComponent] {
        let manager = AVAudioUnitComponentManager.shared()
        let description = AudioComponentDescription(
            componentType: byType, 
            componentSubType: 0, 
            componentManufacturer: 0, 
            componentFlags: 0, 
            componentFlagsMask: 0)
        
        let allComponents = manager.components(matching: description)
        
        return allComponents.filter { $0.isSandboxSafe }
    }
    
    public static func findInstrumentAudioUnits() -> [AVAudioUnitComponent] {
        return findAudioUnits(byType: kAudioUnitType_MusicDevice)
    }
    
    public static func findEffectAudioUnits() -> [AVAudioUnitComponent] {
        return findAudioUnits(byType: kAudioUnitType_Effect) + findAudioUnits(byType: kAudioUnitType_MusicEffect)
    }
    
    public static func findMIDIAudioUnits() -> [AVAudioUnitComponent] {
        return findAudioUnits(byType: kAudioUnitType_MIDIProcessor)
    }
}
