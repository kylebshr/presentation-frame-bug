import UIKit

/// Presents a view contoller with a height of 200pts
class SmolPresentationController: UIPresentationController {

    /// Override the frame for presentation
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }

        let height: CGFloat = 200

        var frame = containerView.frame
        frame.origin.y = frame.height - height
        frame.size.height = height
        return frame
    }

    /// Set the frame to the overriden frame when laying out
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}
