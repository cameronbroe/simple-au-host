import SwiftUI

struct ComponentViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = ComponentViewController
    var auViewController: UIViewController
    
    func makeUIViewController(context: Context) -> ComponentViewController {
        return ComponentViewController()
    }
    
    func updateUIViewController(_ uiViewController: ComponentViewController, context: Context) {
        auViewController.view.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        uiViewController.loadAudioUnitView(auViewController.view)
    }
}
