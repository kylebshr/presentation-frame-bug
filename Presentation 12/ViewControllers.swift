import UIKit

/// Base view controller class with a button that calls a function you can override
class ButtonViewController: UIViewController {
    let button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        button.addTarget(self, action: #selector(performAction), for: .primaryActionTriggered)
        button.tintColor = .white
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = view.bounds
    }

    @objc func performAction() {}
}

/// This view controller presents a SmolViewController, which uses SmolPresentationController to present itself
/// with a height of 200pts
class FirstViewController: ButtonViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setTitle("Present Smol View Controller", for: .normal)
        view.backgroundColor = .purple
    }

    override func performAction() {
        present(SmolViewController(), animated: true)
    }
}

/// SmolViewController presents a full screen view controller over itself
class SmolViewController: ButtonViewController, UIViewControllerTransitioningDelegate {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setTitle("Present Fullscreen View Controller", for: .normal)
        view.backgroundColor = .blue
    }

    override func performAction() {
        let viewController = FullscreenViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SmolPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

/// On iOS 12, when this full screen view controller is dismissed, SmolViewController is incorrectly sized during the transition.
/// It snaps into place when containerViewDidLayoutSubviews is called in SmolPresentationController, after the transition completes.
/// On iOS 13, SmolViewController is correctly sized even during this dismiss transition 🎉 but maybe I'm just doing something wrong on <=12?
class FullscreenViewController: ButtonViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setTitle("Dismiss", for: .normal)
        view.backgroundColor = .brown
    }

    override func performAction() {
        dismiss(animated: true)
    }
}
