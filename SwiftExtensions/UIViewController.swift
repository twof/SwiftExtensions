import UIKit

extension UIViewController {
    func setBackButtonTitle(title: String) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
    }
    
    /// Fades the title of the view to the nav bar as the user scrolls past the header view
    func titleToNavBar(scrollView: UIScrollView, headerView: UIView, title: String) {
        let scrollDist = -1 * (scrollView.contentOffset.y + scrollView.contentInset.top)
        guard let navBar = navigationController?.navigationBar else {return}
        guard let currentTitleColor = navBar.titleTextAttributes?[NSForegroundColorAttributeName] as? UIColor
            else {return}
        guard let prevControllers = self.navigationController?.viewControllers,
            prevControllers.count > 0
            else {return}
        let previousViewController = prevControllers[0]
        
        let fadeSpeed: CGFloat = 2
        
        // Back button fade out math
        let headerFirstQuarter = (headerView.frame.height * -1)/4...0
        
        // Title fade in math
        let headerSecondQuarter = (headerView.frame.height * -1)/2..<(headerFirstQuarter.lowerBound)
        let isTopAnchorInSecondQuarter = headerSecondQuarter.contains(scrollDist)
        let absSecondUpperBound = abs(scrollDist-headerSecondQuarter.upperBound)
        let absSecondLowerBound = abs(headerSecondQuarter.lowerBound)
        let titleAlphaToAnchorRatio = fadeSpeed*(absSecondUpperBound/absSecondLowerBound)
        let titleAlphaComponent = (isTopAnchorInSecondQuarter) ? titleAlphaToAnchorRatio : 1.0
        let titleColorWithAlpha = currentTitleColor.withAlphaComponent
        let scalingAlphaAttributes = [NSForegroundColorAttributeName: titleColorWithAlpha(titleAlphaComponent)]
        let zeroAlphaAttributes = [NSForegroundColorAttributeName: titleColorWithAlpha(0)]
        let oneAlphaAttributes = [NSForegroundColorAttributeName: titleColorWithAlpha(1.0)]
        
        switch scrollDist {
        case headerFirstQuarter:
            navBar.titleTextAttributes = zeroAlphaAttributes
            self.title = ""
            
            if let previousTitle = previousViewController.navigationItem.title {
                previousViewController.setBackButtonTitle(title: previousTitle)
            }
            
        case headerSecondQuarter:
            navBar.titleTextAttributes = scalingAlphaAttributes
            self.title = title
            
            previousViewController.setBackButtonTitle(title: "")
        default:
            navBar.titleTextAttributes = oneAlphaAttributes
        }
    }
    
    /// Adds a subViewController to self
    func add(_ child: UIViewController) {
        addChildViewController(child)
        view.addSubview(child.view)
        child.didMove(toParentViewController: self)
    }
    
    /// Adds a subViewController and constraints to self
    func add(_ child: UIViewController,
             constraints: (UIView) -> [NSLayoutConstraint]) {
        addChildViewController(child)
        view.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.didMove(toParentViewController: self)
        NSLayoutConstraint.activate(constraints(child.view))
    }
    
    /// Removes subViewController to self
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
}
