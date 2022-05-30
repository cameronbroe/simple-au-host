import SwiftUI
import AudioKitUI
import AVFoundation

struct KeyboardViewWrapper: UIViewRepresentable {
    typealias UIViewType = KeyboardView
    let keyboardDelegate: MIDIKeyboardDelegate
    
    func makeUIView(context: Context) -> KeyboardView {
        let view = KeyboardView()
        view.delegate = self.keyboardDelegate
        return view
    }
    
    func updateUIView(_ uiView: KeyboardView, context: Context) {
    }
}
