import UIKit

class ComponentViewController: UIViewController {
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView = UIView()
        self.view.backgroundColor = .cyan
        self.view.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        containerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1).isActive = true
    }
    
    func loadAudioUnitView(_ auView: UIView) {
        containerView.addSubview(auView)
        auView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            auView.topAnchor.constraint(equalTo: containerView.topAnchor),
            auView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            auView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            auView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
}
