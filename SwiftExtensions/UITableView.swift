import UIKit

extension UITableView {
    var sectionHeaders: [UITableViewHeaderFooterView] {
        return (0..<self.numberOfSections).map { (index) -> UITableViewHeaderFooterView? in
            return headerView(forSection: index)
            }.flatMap { $0 }
    }
}
