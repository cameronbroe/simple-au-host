import AudioUnit
import AVFoundation

class AudioUnitRepository {
    public static let availableTypes = [
        kAudioUnitType_Mixer: "Mixer",
        kAudioUnitType_Effect: "Effect",
        kAudioUnitType_Output: "Output",
        kAudioUnitType_Panner: "Panner",
        kAudioUnitType_Generator: "Generator",
        kAudioUnitType_MusicDevice: "Music Device",
        kAudioUnitType_MusicEffect: "Music Effect",
        kAudioUnitType_RemoteEffect: "Remote Effect",
        kAudioUnitType_MIDIProcessor: "MIDI Processor",
        kAudioUnitType_OfflineEffect: "Offline Effect",
        kAudioUnitType_FormatConverter: "Format Converter",
        kAudioUnitType_RemoteGenerator: "Remote Generator",
        kAudioUnitType_RemoteInstrument: "Remote Instrument",
        kAudioUnitType_RemoteMusicEffect: "Remote Music Effect",
    ]
    
    public static let availableSubTypes = [
        kAudioUnitSubType_Delay: "Delay",
        kAudioUnitSubType_Merger: "Merger",
        kAudioUnitSubType_NBandEQ: "N-Band EQ",
        kAudioUnitSubType_Reverb2: "Reverb",
        kAudioUnitSubType_Sampler: "Sampler",
        kAudioUnitSubType_RemoteIO: "Remote I/O",
        kAudioUnitSubType_Splitter: "Splitter",
        kAudioUnitSubType_MIDISynth: "MIDI Synth",
        kAudioUnitSubType_TimePitch: "Time Pitch",
        kAudioUnitSubType_Varispeed: "Varispeed",
        kAudioUnitSubType_Distortion: "Distortion",
        kAudioUnitSubType_AUConverter: "AudioUnit Converter",
        kAudioUnitSubType_MatrixMixer: "Matrix Mixer",
        kAudioUnitSubType_PeakLimiter: "Peak Limiter",
        kAudioUnitSubType_SampleDelay: "Sample Delay",
        kAudioUnitSubType_NewTimePitch: "New Time Pitch",
        kAudioUnitSubType_ParametricEQ: "Parametric EQ",
        kAudioUnitSubType_RoundTripAAC: "RoundTrip AAC",
        kAudioUnitSubType_SpatialMixer: "Spatial Mixer",
        kAudioUnitSubType_GenericOutput: "Generic Output",
        kAudioUnitSubType_LowPassFilter: "Low-Pass Filter",
        kAudioUnitSubType_MultiSplitter: "Multi-Splitter",
        kAudioUnitSubType_BandPassFilter: "Band-Pass Filter",
        kAudioUnitSubType_HighPassFilter: "High-Pass Filter",
        kAudioUnitSubType_LowShelfFilter: "Low-Shelf Filter",
        kAudioUnitSubType_HighShelfFilter: "High-Shelf Filter",
        kAudioUnitSubType_AudioFilePlayer: "Audio File Player",
        kAudioUnitSubType_AUiPodTimeOther: "AU iPod Time / Other",
        kAudioUnitSubType_DeferredRenderer: "Deferred Renderer",
        kAudioUnitSubType_DynamicsProcessor: "Dynamics Processor",
        kAudioUnitSubType_MultiChannelMixer: "Multi-Channel Mixer",
        kAudioUnitSubType_VoiceProcessingIO: "Voice Processing I/O",
        kAudioUnitSubType_ScheduledSoundPlayer: "Scheduled Sound Player",
    ]
    
    public static func findAudioUnits(byType: OSType = 0, bySubType: OSType = 0) -> [AVAudioUnitComponent] {
        let manager = AVAudioUnitComponentManager.shared()
        let description = AudioComponentDescription(
            componentType: byType, 
            componentSubType: 0, 
            componentManufacturer: 0, 
            componentFlags: 0, 
            componentFlagsMask: 0)
        
        return manager.components(matching: description).filter { $0.isSandboxSafe }
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
