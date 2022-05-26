import SwiftUI
import AVFoundation

struct AudioUnitRow: View {
    var audioUnit: AVAudioUnitComponent
    
    var body: some View {
        HStack {
            if let icon = AudioComponentCopyIcon(audioUnit.audioComponent) {
                Image(uiImage: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            VStack(alignment: .leading) {
                Text(audioUnit.name)
                    .font(.system(size: 14))
                Text(audioUnit.manufacturerName)
                    .font(.system(size: 10, weight: .light))
            }
        }
        .frame(height: 30)
    }
}
