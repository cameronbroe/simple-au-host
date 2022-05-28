import AVFoundation

class AudioUnitSession {
    private static let format = AVAudioFormat(
        standardFormatWithSampleRate: 48000, 
        channels: 2)
    
    public static let shared = AudioUnitSession()
    private var audioUnit: AUAudioUnit?
    private var effect: AVAudioUnit?
    
    private let engine = AVAudioEngine()
    
    private init() {
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
    }
    
    public func connectAudioUnit(_ audioUnit: AVAudioUnit) {
        self.resetSession()
        
        self.effect = audioUnit
        self.audioUnit = audioUnit.auAudioUnit
        
        self.engine.attach(self.effect!)
        
        self.engine.connect(self.effect!, to: self.engine.mainMixerNode, format: AudioUnitSession.format)
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            print("set session active")
        } catch {
            print("could not set session active")
        }
        do {
            try self.engine.start()
            print("started engine")
        } catch {
            print("could not start engine")
        }
    }
    
    public func resetSession() {
        if effect != nil {
            engine.disconnectNodeInput(effect!)
            engine.disconnectNodeInput(engine.mainMixerNode)
            
            engine.detach(effect!)
            
            effect = nil
            audioUnit = nil
        }
    }
}
