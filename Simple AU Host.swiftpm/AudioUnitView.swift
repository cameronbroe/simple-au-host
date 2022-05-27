import SwiftUI
import AVFoundation
import CoreAudioKit

struct AudioUnitView: View {
    var audioUnit: AVAudioUnitComponent
    @State var auViewController: UIViewController? = nil
    @State var didError = false
    @State var errorMessage = ""
    
    private let viewConfigurations: [AUAudioUnitViewConfiguration] = {
        let expanded = AUAudioUnitViewConfiguration(width: 800, height: 500, hostHasController: false)
        return [expanded]
    }()
    
    var body: some View {
        if let vc = auViewController {
//            print(vc.view.autoresizesSubviews)
//            return AudioUnitViewControllerWrapper(controller: vc)
            return ComponentViewControllerWrapper(auViewController: vc)
        } else {
            return Text("AudioUnit view controller not ready yet")
                .alert(errorMessage, isPresented: $didError) {}
                .task {
                    do {
                        let avAudioUnit = try await AVAudioUnit.instantiate(with: audioUnit.audioComponentDescription, options: .loadOutOfProcess)
                        
                        let audioUnit = avAudioUnit.auAudioUnit
                        audioUnit.requestViewController { vc in
                            DispatchQueue.main.async {
                                auViewController = vc
                            }
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
