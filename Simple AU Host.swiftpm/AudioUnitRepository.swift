import AudioUnit
import AVFoundation

struct AudioUnitData {
    let name: String
}

class AudioUnitRepository {
    public let availableTypes = [
        kAudioUnitType_Mixer,
        kAudioUnitType_Effect,
        kAudioUnitType_Output,
        kAudioUnitType_Panner,
        kAudioUnitType_Generator,
        kAudioUnitType_MusicDevice,
        kAudioUnitType_MusicEffect,
        kAudioUnitType_RemoteEffect,
        kAudioUnitType_MIDIProcessor,
        kAudioUnitType_OfflineEffect,
        kAudioUnitType_FormatConverter,
        kAudioUnitType_RemoteGenerator,
        kAudioUnitType_RemoteInstrument,
        kAudioUnitType_RemoteMusicEffect,
    ]
    
    public let availableSubTypes = [
        kAudioUnitSubType_Delay,
        kAudioUnitSubType_Merger,
        kAudioUnitSubType_NBandEQ,
        kAudioUnitSubType_Reverb2,
        kAudioUnitSubType_Sampler,
        kAudioUnitSubType_RemoteIO,
        kAudioUnitSubType_Splitter,
        kAudioUnitSubType_MIDISynth,
        kAudioUnitSubType_TimePitch,
        kAudioUnitSubType_Varispeed,
        kAudioUnitSubType_Distortion,
        kAudioUnitSubType_AUConverter,
        kAudioUnitSubType_MatrixMixer,
        kAudioUnitSubType_PeakLimiter,
        kAudioUnitSubType_SampleDelay,
        kAudioUnitSubType_NewTimePitch,
        kAudioUnitSubType_ParametricEQ,
        kAudioUnitSubType_RoundTripAAC,
        kAudioUnitSubType_SpatialMixer,
        kAudioUnitSubType_GenericOutput,
        kAudioUnitSubType_LowPassFilter,
        kAudioUnitSubType_MultiSplitter,
        kAudioUnitSubType_BandPassFilter,
        kAudioUnitSubType_HighPassFilter,
        kAudioUnitSubType_LowShelfFilter,
        kAudioUnitSubType_HighShelfFilter,
        kAudioUnitSubType_AudioFilePlayer,
        kAudioUnitSubType_AUiPodTimeOther,
        kAudioUnitSubType_DeferredRenderer,
        kAudioUnitSubType_DynamicsProcessor,
        kAudioUnitSubType_MultiChannelMixer,
        kAudioUnitSubType_VoiceProcessingIO,
        kAudioUnitSubType_ScheduledSoundPlayer,
    ]
    
    public func findAudioUnits(byType: OSType = 0, bySubType: OSType = 0) -> [AVAudioUnitComponent] {
        let manager = AVAudioUnitComponentManager.shared()
        let description = AudioComponentDescription(
            componentType: byType, 
            componentSubType: bySubType, 
            componentManufacturer: 0, 
            componentFlags: 0, 
            componentFlagsMask: 0)
        
        return manager.components(matching: description)
    }
}
