import SwiftUI
import AVFoundation
import CoreAudioKit

struct AudioUnitView: View {
    var audioUnit: AVAudioUnitComponent
    @State var auViewController: UIViewController? = nil
    @State var avAudioUnit: AVAudioUnit? = nil
    @State var didError = false
    @State var errorMessage = ""
    
    var body: some View {
        if let vc = auViewController {
            return AudioUnitViewControllerWrapper(controller: vc)
        } else {
            return Text("AudioUnit view controller not ready yet")
                .alert(errorMessage, isPresented: $didError) {}
                .task {
                    do {
                        avAudioUnit = try await AVAudioUnit.instantiate(with: audioUnit.audioComponentDescription)
                        
                        let audioUnit = avAudioUnit?.auAudioUnit
                        let viewController = await audioUnit?.requestViewController()
                        DispatchQueue.main.async {
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
