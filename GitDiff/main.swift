//
//  main.swift
//  GitDiff
//
//  Created by DươngPQ on 09/03/2018.
//  Copyright © 2018 GMO-Z.com RunSystem. All rights reserved.
//

import AppKit
import ObjectiveGit
import Differ

var filterExtensions = [String]()
var excluedPaths = [String]()
var filterPaths = [String]()
var copyright = ""
var author = NSFullUserName()
let kCreatedDateFormat = "y/MM/dd HH:mm"
let kVersion = "1.3"
var uncheckedFiles = [GTDiffDelta]()
var isHideContext = false

print("Git Diff LOC Count by DươngPQ v\(kVersion)")
print("Copyright © 2019 GMO-Z.com RunSystem. All rights reserved.")
print("---")

func formatDate(format: String, date: Date = Date()) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale.current
    formatter.timeZone = TimeZone.current
    formatter.calendar = Calendar.current
    formatter.dateFormat = format
    return formatter.string(from: date)
}

private func printError(_ str: String) {
    if let data = ("ERROR: " + str + "\n").data(using: .utf8) {
        let fileHandle = FileHandle.standardError
        fileHandle.write(data)
    }
}

func formatHTML(_ str: String?) -> String {
    if let s = str {
        var result = ""
        let escapes: [Character: String] = ["\n": "<br/>", "&": "&amp;", "<": "&lt;", ">": "&gt;", "\"": "&quot;", "'": "&#39;"]
        for char in s {
            if let target = escapes[char] {
                result += target
            } else {
                result.append(char)
            }
        }
        return result
    }
    return ""
}

private func filterFile(_ path: String) -> Bool {
    for excluded in excluedPaths where path.hasPrefix(excluded) {
        return false
    }
    var result = false
    if filterExtensions.count > 0 {
        for ext in filterExtensions where path.hasSuffix("." + ext) {
            result = true
            break
        }
    } else {
        result = true
    }
    if result && filterPaths.count > 0 {
        result = false
        for fPath in filterPaths where path.hasPrefix(fPath) {
            result = true
            break
        }
    }
    return result
}

private func printUsage() {
    print("Usage: \((CommandLine.arguments.first as NSString?)?.lastPathComponent ?? "") <old local branch name> <new local branch name> [-x<excluded path> ...] [-X<excluded list input file>] [-f<filter path> ...] [-F<filter list input file>] [-e<file extension> ...] [-a<Author>] [-c<Copyright>] [-hctx] [outout file]")
    print("\tWe don't check files in folder given in -x, -X and their subfolders.")
    print("\tWe ONLY check files in folder given in -f, -F and their subfolders.")
    print("\t-x, -f, -e may repeat.")
    print("\t-X, -F equivalent to -x, -f, but the paths are in the given file, each path on line.")
    print("\tWe check files having extension given in -e. If you don't give this option, default extensions is 'swift', 'h', 'm'. To check all files, give one -e (with empty extension).")
    print("\t-hctx: hide context lines.")
}

if CommandLine.argc < 3 {
    printUsage()
    exit(0)
}
let oldBranch = CommandLine.arguments[1]
let newBranch = CommandLine.arguments[2]
var outFile: String?
if oldBranch == newBranch {
    printError("2 branch names are the same!")
    exit(1)
}
var isAllFiles = false
for i in 3 ..< CommandLine.argc {
    let index = Int(i)
    let param = CommandLine.arguments[index]
    if param.hasPrefix("-x") && param.count > 2 { // Paths to exclude from diff
        excluedPaths.append(String(param[param.index(param.startIndex, offsetBy: 2)...]))
    } else if param.hasPrefix("-X") && param.count > 2 { // Paths to exclude from diff, input from file
        let path = String(param[param.index(param.startIndex, offsetBy: 2)...])
        if let content = try? String(contentsOfFile: path) {
            let lines = content.components(separatedBy: CharacterSet.newlines)
            for line in lines where line.count > 0 {
                excluedPaths.append(line)
            }
        }
    } else if param.hasPrefix("-f") && param.count > 2 { // only diff this file
        filterPaths.append(String(param[param.index(param.startIndex, offsetBy: 2)...]))
    } else if param.hasPrefix("-F") && param.count > 2 { // only diff file(s) in the given file.
        let path = String(param[param.index(param.startIndex, offsetBy: 2)...])
        if let content = try? String(contentsOfFile: path) {
            let lines = content.components(separatedBy: CharacterSet.newlines)
            for line in lines where line.count > 0 {
                filterPaths.append(line)
            }
        }
    } else if param.hasPrefix("-e") {
        if param.count > 2 {
            let ext = String(param[param.index(param.startIndex, offsetBy: 2)...])
            filterExtensions.append(ext)
        } else {
            isAllFiles = true
        }
    } else if param.hasPrefix("-a") {
        if param.count > 2 {
            author = String(param[param.index(param.startIndex, offsetBy: 2)...])
        } else {
            author = ""
        }
    } else if param.hasPrefix("-c") {
        if param.count > 2 {
            copyright = String(param[param.index(param.startIndex, offsetBy: 2)...])
        } else {
            copyright = ""
        }
    } else if param == "-hctx" {
        isHideContext = true
    } else {
        outFile = param
    }
}
if isAllFiles {
    filterExtensions.removeAll()
} else if filterExtensions.count == 0 {
    filterExtensions = ["swift", "h", "m"]
}

do {
    let repo = try GTRepository(url: URL(fileURLWithPath: FileManager.default.currentDirectoryPath))
    do {
        let localBranches = try repo.localBranches()
        var oTree: GTTree?
        var nTree: GTTree?
        for branch in localBranches {
            if let name = branch.name, let target = branch.reference.resolvedTarget as? GTCommit {
                if name == oldBranch {
                    oTree = target.tree
                } else if name == newBranch {
                    nTree = target.tree
                }
            }
        }
        if let oldTree = oTree, let newTree = nTree {
            do {
                let diff = try GTDiff(oldTree: oldTree, withNewTree: newTree, in: repo, options: nil)
                var files = [String: GDFileDiff]()
                diff.enumerateDeltas({ (delta, _) in
                    if filterFile(delta.newFile.path) {
                        let fileDiff: GDFileDiff
                        if let f = files[delta.newFile.path] {
                            fileDiff = f
                        } else {
                            fileDiff = GDFileDiff(delta.newFile.path)
                            files[delta.newFile.path] = fileDiff
                            fileDiff.type = delta.type
                        }
                        if let patch = try? delta.generatePatch() {
                            patch.enumerateHunks({ (hunk, _) in
                                var lastLine: GTDiffLine? = nil
                                try? hunk.enumerateLinesInHunk(usingBlock: { (line, _) in
                                    fileDiff.processLine(line: line, preLine: lastLine)
                                    lastLine = line
                                })
                            })
                            fileDiff.closeHunk()
                        }
                    } else {
                        uncheckedFiles.append(delta)
                    }
                })

                // Check moved files
                var movedFilesCount = 0
                var addedFiles = [GDFileDiff]()
                var removedFiles = [GDFileDiff]()
                for (_, f) in files {
                    switch f.type {
                    case .added:
                        addedFiles.append(f)
                    case .deleted:
                        removedFiles.append(f)
                    default:
                        break
                    }
                }

                for addedFile in addedFiles {
                    var originFile: GDFileDiff?
                    var indexToRm = 0
                    for rmFile in removedFiles {
                        var isSame = addedFile.lines.count == rmFile.lines.count
                        if isSame {
                            for aLine in addedFile.lines {
                                if let aLineNum = aLine.newNumber, aLine.oldNumber == nil {
                                    var found = false
                                    for bLine in rmFile.lines {
                                        if let bLineNum = bLine.oldNumber, bLine.newNumber == nil, bLineNum == aLineNum {
                                            isSame = aLine.new == bLine.old
                                            found = true
                                            break
                                        }
                                    }
                                    if !found { isSame = false }
                                } else {
                                    isSame = false
                                }
                                if !isSame {
                                    break
                                }
                            }
                            if isSame {
                                for aLine in rmFile.lines {
                                    if let aLineNum = aLine.oldNumber, aLine.newNumber == nil {
                                        var found = false
                                        for bLine in addedFile.lines {
                                            if let bLineNum = bLine.newNumber, bLine.oldNumber == nil, bLineNum == aLineNum {
                                                isSame = aLine.old == bLine.new
                                                found = true
                                                break
                                            }
                                        }
                                        if !found { isSame = false }
                                    } else {
                                        isSame = false
                                    }
                                    if !isSame {
                                        break
                                    }
                                }
                            }
                        }
                        if isSame {
                            originFile = rmFile
                            break
                        }
                        indexToRm += 1
                    }
                    if let f = originFile {
                        movedFilesCount += 1
                        addedFile.renamedOrigin = f
                        addedFile.isOriginSame = true
                        removedFiles.remove(at: indexToRm)
                        _ = files.removeValue(forKey: f.path)
                        _ = files.removeValue(forKey: addedFile.path)
                    } else {
                        indexToRm = 0
                        originFile = nil
                        for rmFile in removedFiles {
                            if (rmFile.path as NSString).lastPathComponent == (addedFile.path as NSString).lastPathComponent {
                                originFile = rmFile
                                break
                            }
                            indexToRm += 1
                        }
                        if let f = originFile {
                            addedFile.renamedOrigin = f
                            addedFile.isOriginSame = false
                            removedFiles.remove(at: indexToRm)
                            _ = files.removeValue(forKey: f.path)
                            addedFile.mergeFromOrign()
                        }
                    }
                }

                var allAdd: UInt = 0
                var allRm: UInt = 0
                var allMod: UInt = 0
                var allLow: UInt = 0
                var allGitAdd: UInt = 0
                var allGitRm: UInt = 0
                for (_, f) in files {
                    let (a, r, m, l) = f.getStatistics(true)
                    allAdd += a
                    allRm += r
                    allMod += m
                    allLow += l
                    allGitAdd += f.gitAdd
                    allGitRm += f.gitRm
                }

                // Summary
                print("Total deltas: \(diff.deltaCount). Checked files: \(files.count).")
                print("Added: \(allAdd).")
                print("Removed: \(allRm).")
                print("Modified: \(allMod).")
                print("Low meaning: \(allLow).")
                if movedFilesCount > 0 {
                    print("Moved files: \(movedFilesCount).")
                }
                if uncheckedFiles.count > 0 {
                    print("Unchecked files: \(uncheckedFiles.count).")
                }

                if var output = outFile {
                    if output.hasPrefix("~") {
                        output = NSHomeDirectory() + String(output[output.index(after: output.startIndex)..<output.endIndex])
                    } else if !output.hasPrefix("/") {
                        output = FileManager.default.currentDirectoryPath + "/" + output
                    }
                    print("Writting diff into \"\(output)\"...")
                    try? "".write(toFile: output, atomically: true, encoding: .utf8)
                    if let fileWriter = FileHandle(forWritingAtPath: output) {
                        fileWriter.writeHTMLHead()
                        var totalSections = files.count
                        if movedFilesCount > 0 {
                            totalSections += 1
                        }
                        if uncheckedFiles.count > 0 {
                            totalSections += 1
                        }
                        fileWriter.writeHTMLBodyHead(basePath: formatHTML(FileManager.default.currentDirectoryPath),
                                                     totalAdd: allAdd, totalRemove: allRm, totalMod: allMod, totalLowM: allLow,
                                                     totalGitAdd: allGitAdd, totalGitRemove: allGitRm,
                                                     filesCount: totalSections, version: kVersion)
                        fileWriter.writeTableHead(oldBranch: oldBranch, newBranch: newBranch)
                        // Files & Lines diff
                        var index = 0
                        let sortedPath = files.keys.sorted()
                        for key in sortedPath {
                            guard let f = files[key] else { continue }
                            let (a, r, m, l) = f.getStatistics()
                            fileWriter.writeFileHeadRow(path: f.path, addN: a, rmN: r, modN: m, lowN: l, gAddN: f.gitAdd, gRmN: f.gitRm, index: index)
                            // Code diff lines
                            for line in f.lines {
                                if isHideContext && line.isContext {
                                    continue
                                }
                                let color: HtmlStatusClass
                                let txtColor1: HtmlTextClass
                                let txtColor2: HtmlTextClass
                                switch line.status {
                                case .added:
                                    color = .add
                                    txtColor1 = .low
                                    txtColor2 = .add
                                case .removed:
                                    color = .remove
                                    txtColor1 = .remove
                                    txtColor2 = .low
                                case .modified:
                                    color = .mod
                                    txtColor1 = .mod
                                    txtColor2 = .mod
                                default:
                                    color = .low
                                    txtColor1 = .low
                                    txtColor2 = .low
                                }
                                let (old, new) = line.getMarkedDiff()
                                fileWriter.writeDiffCodeLine(index: index, statusClass: color, statusContent: line.status.rawValue,
                                                             oldNum: line.oldNumber, oldClass: txtColor1, oldContent: old,
                                                             newNum: line.newNumber, newClass: txtColor2, newContent: new)
                            }
                            index += 1
                        }
                        var fileIndex = UInt(index + 1)
                        // File Move
                        if movedFilesCount > 0 {
                            fileWriter.writeFileMovedHead(fileCount: movedFilesCount, index: index)
                            for f in addedFiles where f.isOriginSame {
                                if let originF = f.renamedOrigin {
                                    let old = GDLineDiff.generateDiff(source: originF.path, target: f.path)
                                    let new = GDLineDiff.generateDiff(source: f.path, target: originF.path)
                                    fileWriter.writeDiffCodeLine(index: index, statusClass: .low, statusContent: "\(fileIndex)",
                                                                 oldNum: UInt(f.lines.count), oldClass: .low, oldContent: old,
                                                                 newNum: UInt(f.lines.count), newClass: .low, newContent: new)
                                    fileIndex += 1
                                }
                            }
                            index += 1
                        }
                        if uncheckedFiles.count > 0 {
                            uncheckedFiles.sort { (left, right) -> Bool in
                                return left.newFile.path < right.newFile.path
                            }
                            var ucAdd: UInt = 0
                            var ucMod: UInt = 0
                            var ucRm: UInt = 0
                            for item in uncheckedFiles {
                                switch item.type {
                                case .added:
                                    ucAdd += 1
                                case .deleted:
                                    ucRm += 1
                                case .modified:
                                    ucMod += 1
                                default:
                                    break
                                }
                            }
                            fileWriter.writeUncheckedFileHead(fileCount: uncheckedFiles.count, index: index, addN: ucAdd, modN: ucMod, rmN: ucRm)
                            for item in uncheckedFiles {
                                let color: HtmlStatusClass
                                let txtColor1: HtmlTextClass
                                let txtColor2: HtmlTextClass
                                let text1: String
                                let text2: String
                                switch item.type {
                                case .added:
                                    color = .add
                                    txtColor1 = .low
                                    txtColor2 = .add
                                    text1 = ""
                                    text2 = item.newFile.path
                                case .deleted:
                                    color = .remove
                                    txtColor1 = .remove
                                    txtColor2 = .low
                                    text1 = item.oldFile.path
                                    text2 = ""
                                case .modified:
                                    color = .mod
                                    txtColor1 = .mod
                                    txtColor2 = .mod
                                    text1 = item.oldFile.path
                                    text2 = item.newFile.path
                                default:
                                    color = .low
                                    txtColor1 = .low
                                    txtColor2 = .low
                                    text1 = item.oldFile.path
                                    text2 = item.newFile.path
                                }
                                fileWriter.writeDiffCodeLine(index: index, statusClass: color, statusContent: "\(fileIndex)",
                                                             oldNum: nil, oldClass: txtColor1, oldContent: text1,
                                                             newNum: nil, newClass: txtColor2, newContent: text2)
                                fileIndex += 1
                            }
                            index += 1
                        }
                        // END
                        fileWriter.writeTermination(author: formatHTML(author), copyright: formatHTML(copyright),
                                                    extensions: filterExtensions, filterPaths: filterPaths, excludePaths: excluedPaths)
                        fileWriter.closeFile()
                        NSWorkspace.shared.openFile(output)
                    } else {
                        printError("Could not open \"\(output)\" to write!")
                    }
                }
            } catch (let e) {
                printError("Fail to load diff of 2 given branches!\n\(e)")
                exit(1)
            }
        } else {
            printError("Branches not found!")
            exit(1)
        }
    } catch (let e) {
        printError("Fail to load local branches list!\n\(e)")
        exit(1)
    }
} catch ( let e ) {
    printError("Current directory is not GIT working folder!\n\(e)")
    exit(1)
}
