//
//  GDFileDiff.swift
//  GitDiff
//
//  Created by DươngPQ on 09/03/2018.
//  Copyright © 2018 GMO-Z.com RunSystem. All rights reserved.
//

import Foundation
import ObjectiveGit

let kDiffBegin = "🚩"
let kDiffEnd = "🏁"

class GDDiffRange: CustomStringConvertible {

    var lower: Int
    var higher: Int

    init(low: Int, high: Int) {
        lower = low
        higher = high
    }


    var length: Int {
        return higher - lower + 1
    }

    var description: String {
        return "[\(lower)-\(higher):\(length)]"
    }

}

class GDLineDiff {

    enum Status: String {
        case added = "+"
        case removed = "-"
        case modified = "m"
        case unchanged = ""
    }

    var newNumber: UInt?
    var oldNumber: UInt?
    var old: String?
    var new: String?
    var isContext = false

    var status: Status = .unchanged
    var oldCommentStatus = false
    var newCommentStatus = false

    var description: String {
        var result = status.rawValue + " \(newNumber ?? 0):"
        if let str = old {
            result += " \"\(str)\""
        }
        if let str = new {
            result += " \"\(str)\""
        }
        return result
    }

    static func formatCode(_ str: String?) -> String {
        if let s = str {
            return s.replacingOccurrences(of: " ", with: "·")
        }
        return ""
    }

    static func generateDiff(source: String, target: String, useMarker: Bool = false) -> String {
        let diff = source.diff(target)
        var ranges = [GDDiffRange]()
        var currentRange: GDDiffRange?
        var lastIndex: Int?
        for element in diff.elements {
            switch element {
            case .delete(let index):
                if let range = currentRange, let i = lastIndex, i == index - 1 {
                    range.higher += 1
                } else {
                    let r = GDDiffRange(low: index, high: index)
                    ranges.append(r)
                    currentRange = r
                }
                lastIndex = index
            case .insert(_):
                break
            }
        }
        if ranges.count == 0 { return source.replacingOccurrences(of: " ", with: "·") }
        var result = ""
        var lastRange: GDDiffRange?
        for range in ranges {
            if let lRange = lastRange {
                result += formatCode(String(source[source.index(source.startIndex, offsetBy: lRange.higher + 1)..<source.index(source.startIndex, offsetBy: range.lower)]))
            } else if range.lower != 0 {
                result += formatCode(String(source[source.startIndex..<source.index(source.startIndex, offsetBy: range.lower)]))
            }
            result += (useMarker ? kDiffBegin : "<b>") + formatCode(String(source[source.index(source.startIndex, offsetBy: range.lower)...source.index(source.startIndex, offsetBy: range.higher)])) + (useMarker ? kDiffEnd : "</b>")
            lastRange = range
        }
        if let last = ranges.last, last.higher < source.count - 1 {
            result += formatCode(String(source[source.index(source.startIndex, offsetBy: last.higher + 1)..<source.endIndex]))
        }
        return result
    }

    static func unmarkDiff(_ input: String) -> String {
        var result = input.replacingOccurrences(of: kDiffBegin, with: "<b>")
        result = result.replacingOccurrences(of: kDiffEnd, with: "</b>")
        return result
    }

    private func removeBlockComment(beginRange: Range<String.Index>, content: inout String) -> Bool {
        if let range4 = content.range(of: "*/"), range4.lowerBound > beginRange.upperBound {
            content = String(content[..<beginRange.lowerBound]) + String(content[range4.upperBound...])
            return removeComments(&content)
        } else {
            content = String(content[..<beginRange.lowerBound])
            return true
        }
    }

    private func removeComments(_ content: inout String) -> Bool {
        content = content.trimmingCharacters(in: CharacterSet(charactersIn: "\t "))

        let range1 = content.range(of: "//")
        let range2 = content.range(of: "/*")
        if let rg1 = range1, let rg2 = range2 {
            if rg1.lowerBound < rg2.lowerBound {
                content = String(content[..<rg1.lowerBound])
            } else {
                return removeBlockComment(beginRange: rg2, content: &content)
            }
        } else if let rg1 = range1 {
             content = String(content[..<rg1.lowerBound])
        } else if let rg2 = range2 {
            return removeBlockComment(beginRange: rg2, content: &content)
        }
        return false
    }

    private func validateLine(content: String, preStatus: Bool?, commentStatus: inout Bool) -> Bool {
        var cnt = content
        if let cmtStatus = preStatus, cmtStatus {
            if let rangeEnd = cnt.range(of: "*/") {
                cnt = String(cnt[rangeEnd.upperBound...])
                commentStatus = false
            } else {
                commentStatus = true
                return false
            }
        }
        commentStatus = removeComments(&cnt)

        let charSet = CharacterSet(charactersIn: "{}()[]")
        let trimmed = cnt.trimmingCharacters(in: charSet)
        return trimmed.count > 0
    }

    func makeStatus(_ preLine: GDLineDiff?) {
        status = .unchanged
        if isContext { return }
        var pLine: GDLineDiff?
        if let pln = preLine {
            if let newNum = self.newNumber, let pnwNum = pln.newNumber, Int(newNum) - Int(pnwNum) == 1 {
                pLine = pln
            }
            if let oldNum = self.oldNumber, let poldNum = pln.oldNumber, Int(oldNum) - Int(poldNum) == 1 {
                pLine = pln
            }
        }
        if let oldLine = old, let newLine = new {
            let oldValid = validateLine(content: oldLine,
                                        preStatus: pLine?.oldCommentStatus,
                                        commentStatus: &oldCommentStatus)
            let newValid = validateLine(content: newLine,
                                        preStatus: pLine?.newCommentStatus,
                                        commentStatus: &newCommentStatus)
            if oldValid && newValid {
                if oldLine != newLine {
                    status = .modified
                }
            } else if oldValid {
                status = .removed
            } else if newValid {
                status = .added
            }
        } else if let newLine = new, validateLine(content: newLine,
                                                  preStatus: pLine?.newCommentStatus,
                                                  commentStatus: &newCommentStatus) {
            status = .added
        } else if let oldLine = old, validateLine(content: oldLine,
                                                  preStatus: pLine?.oldCommentStatus,
                                                  commentStatus: &oldCommentStatus) {
            status = .removed
        }
    }

    func getMarkedDiff() -> (String, String) {
        let resOld: String
        let resNew: String
        if let str1 = old, let str2 = new {
            var str11 = GDLineDiff.generateDiff(source: str1, target: str2, useMarker: true)
            var str22 = GDLineDiff.generateDiff(source: str2, target: str1, useMarker: true)
            str11 = GDLineDiff.unmarkDiff(formatHTML(str11))
            str22 = GDLineDiff.unmarkDiff(formatHTML(str22))
            resOld = str11
            resNew = str22
        } else {
            resOld = GDLineDiff.formatCode(formatHTML(old))
            resNew = GDLineDiff.formatCode(formatHTML(new))
        }
        return (resOld, resNew)
    }

}

class GDFileDiff {

    let path: String
    var lines = [GDLineDiff]()
    var type: GTDeltaType = .unmodified
    var renamedOrigin: GDFileDiff?
    var isOriginSame = false

    var gitAdd: UInt = 0
    var gitRm: UInt = 0

    private var currentHunkLines: [GDLineDiff]?

    init(_ p: String) {
        path = p
    }

    private func addLineToHunk(_ line: GTDiffLine) {
        var hunkLines: [GDLineDiff]
        if let hnkLines = currentHunkLines {
            hunkLines = hnkLines
        } else {
            hunkLines = []
        }
        var found = false
        for hLine in hunkLines {
            if line.origin == .addition {
                if hLine.newNumber == nil {
                    hLine.newNumber = UInt(line.newLineNumber)
                    hLine.new = line.content
                    found = true
                    break
                }
            } else {
                if hLine.oldNumber == nil {
                    hLine.oldNumber = UInt(line.oldLineNumber)
                    hLine.old = line.content
                    found = true
                    break
                }
            }
        }
        if !found {
            let dLine = GDLineDiff()
            if line.origin == .addition {
                dLine.new = line.content
                dLine.newNumber = UInt(line.newLineNumber)
            } else {
                dLine.old = line.content
                dLine.oldNumber = UInt(line.oldLineNumber)
            }
            hunkLines.append(dLine)
        }
        currentHunkLines = hunkLines
    }

    func closeHunk() {
        guard let hunkLines = currentHunkLines else { return }
        lines.append(contentsOf: hunkLines)
        currentHunkLines = nil
    }

    func processLine(line: GTDiffLine, preLine: GTDiffLine?) {
        switch line.origin {
        case .context:
            closeHunk()
            let dLine = GDLineDiff()
            dLine.isContext = true
            dLine.newNumber = UInt(line.newLineNumber)
            dLine.oldNumber = UInt(line.oldLineNumber)
            dLine.old = line.content
            dLine.new = line.content
            lines.append(dLine)
        case .addition:
            addLineToHunk(line)
            gitAdd += 1
        case .deletion:
            addLineToHunk(line)
            gitRm += 1
        default:
            break
        }
    }

    /// return: (Add, Remove, Modify, LowValue)
    func getStatistics(_ makeStatus: Bool = false) -> (UInt, UInt, UInt, UInt) {
        var addCount: UInt = 0
        var rmCount: UInt = 0
        var modCount: UInt = 0
        var lowCount: UInt = 0
        var lastLine: GDLineDiff?
        for line in lines {
            if makeStatus {
                line.makeStatus(lastLine)
                lastLine = line
            }
            switch line.status {
            case .added:
                addCount += 1
            case .removed:
                rmCount += 1
            case .modified:
                modCount += 1
            default:
                if !line.isContext {
                    lowCount += 1
                }
            }

        }
        return (addCount, rmCount, modCount, lowCount)
    }

    func mergeFromOrign() {
        guard let originFile = renamedOrigin else { return }
        let newLines = lines
        var oldLInes = originFile.lines
        var result = [GDLineDiff]()

        var currentHunk: [GDLineDiff]?

        let closeHunk = {
            guard let curHunk = currentHunk else { return }
            result.append(contentsOf: curHunk)
            currentHunk = nil
        }

        let appendHunk: (GDLineDiff, Bool) -> Void = { input, isNew in
            var hunk: [GDLineDiff]
            if let cHunk = currentHunk {
                hunk = cHunk
            } else {
                hunk = []
            }
            var found = false
            for line in hunk {
                if isNew {
                    if line.newNumber == nil {
                        line.newNumber = input.newNumber
                        line.new = input.new
                        found = true
                        break
                    }
                } else {
                    if line.oldNumber == nil {
                        line.oldNumber = input.oldNumber
                        line.old = input.old
                        found = true
                        break
                    }
                }
            }
            if !found {
                hunk.append(input)
            }
            currentHunk = hunk
        }

        for newLine in newLines {
            var contextNew: GDLineDiff?
            var contextOld: GDLineDiff?
            var oldLineHunk = [GDLineDiff]()
            for oldLine in oldLInes {
                if oldLine.old == newLine.new {
                    contextNew = newLine
                    contextOld = oldLine
                    break
                } else {
                    oldLineHunk.append(oldLine)
                }
            }
            if let ctxNew = contextNew, let ctxOld = contextOld {
                for oldLine in oldLineHunk {
                    appendHunk(oldLine, false)
                    _ = oldLInes.removeFirst()
                }
                _ = oldLInes.removeFirst()
                closeHunk()
                let ctxLine = GDLineDiff()
                ctxLine.oldNumber = ctxOld.oldNumber
                ctxLine.old = ctxOld.old
                ctxLine.newNumber = ctxNew.newNumber
                ctxLine.new = ctxNew.new
                result.append(ctxLine)
            } else {
                appendHunk(newLine, true)
            }
        }
        closeHunk()

        lines = result
    }

}
