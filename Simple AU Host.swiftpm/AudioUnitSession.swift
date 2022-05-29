import AVFoundation

class AudioUnitSession {
    public static let shared = AudioUnitSession()
    private var audioUnit: AUAudioUnit?
    private var effect: AVAudioUnit?
    
    private let engine = AVAudioEngine()
    
    private init() {
        setupNotifications()
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord)
    }
    
    func setupNotifications() {
        let name = Notification.Name(String(kAudioComponentInstanceInvalidationNotification))
        NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil) { [weak self] notification in
            if let crashedAU = notification.object as? AUAudioUnit {
                print(crashedAU.debugDescription)
                print(notification.debugDescription)
            }
        }
    }
    
    public func connectAudioUnit(_ audioUnit: AVAudioUnit) {
        self.resetSession()
        
        self.effect = audioUnit
        self.audioUnit = audioUnit.auAudioUnit
        
        self.engine.attach(self.effect!)
        
        self.engine.connect(self.effect!, 
                            to: self.engine.mainMixerNode, 
                            format: self.audioUnit!.outputBusses[0].format)
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            print("set session active")
        } catch {
            print("could not set session active")
        }
        do {
            self.engine.prepare()
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
