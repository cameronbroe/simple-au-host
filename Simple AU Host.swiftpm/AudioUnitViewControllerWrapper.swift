import SwiftUI

struct AudioUnitViewControllerWrapper: UIViewControllerRepresentable {
    let controller: UIViewController
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
