import UIKit

extension UITableView {
    var dequeuedSectionHeaders: [UITableViewHeaderFooterView] {
        return (0..<self.numberOfSections).map { (index) -> UITableViewHeaderFooterView? in
            return headerView(forSection: index)
            }.flatMap { $0 }
    }
}

extension UITableView {
    var sectionHeaders: [UITableViewHeaderFooterView]? {
        guard let deleg = self.delegate else { return nil }
        return (0..<self.numberOfSections).map { (index) -> UITableViewHeaderFooterView? in
            guard let view = deleg.tableView?(self, viewForHeaderInSection: index) as? UITableViewHeaderFooterView
                else { return nil }
            return view
            }.flatMap { $0 }
    }
}
