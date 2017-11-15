import Foundation

extension String {
    func index(of string: String, options: CompareOptions = .literal) -> Int? {
        return range(of: string, options: options)?.lowerBound.encodedOffset
    }

    func substring(with range: Range<Int>) -> String? {
        let start = Index(encodedOffset: range.lowerBound)
        let end = Index(encodedOffset: range.upperBound)
        return String(self[start..<end])
    }

    /// Like the built in split function, but it retains the seperating characters
    /// and supports multiple seperators.
    func splitBefore(seperators: [String]) -> [String]{
        var tokens: [String] = [self]

        for s in seperators {
            var newTokens: [String] = []

            for t in tokens {
                newTokens.append(contentsOf: t.splitBefore(seperator: s))
            }

            tokens = newTokens
        }

        return tokens
    }

    /// Like the built in split function, but it retains the seperating character
    func splitBefore(seperator: String) -> [String] {
        let s = seperator
        var tokens: [String] = []
        var remaining = self

        while let i = remaining.substring(with: (s.count-1)..<remaining.count)?.index(of: s)?.advanced(by: (s.count-1)),
            let before = remaining.substring(with: 0..<i),
            let after = remaining.substring(with: i..<remaining.count) {
                tokens.append(before.trimmingCharacters(in: .whitespaces))
                remaining = after
        }

        tokens.append(remaining.trimmingCharacters(in: .whitespaces))

        return tokens
    }

    /// Splits a commandline input string and seperates flags along with their parameters
    func tokenizeCommandline() -> [String] {
        return self.splitBefore(seperators: [" --", " -"])
    }

    /// Returns true if a string has any one of a list of prefixes
    /// Can be treated like a boolean OR
    func hasPrefix(prefix: [String]) -> Bool{
        for pre in prefix {
            if self.contains(pre) {
                return true
            }
        }
        return false
    }
}
