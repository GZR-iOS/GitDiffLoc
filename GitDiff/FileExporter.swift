//
//  FileExporter.swift
//  GitDiff
//
//  Created by DươngPQ on 4/3/19.
//  Copyright © 2019 GMO-Z.com RunSystem. All rights reserved.
//

import Foundation

enum HtmlStatusClass: String {
    case add = "add_status"
    case mod = "mod_status"
    case remove = "rm_status"
    case low = "ch_status"
}

enum HtmlTextClass: String {
    case add = "add_txt"
    case mod = "mod_txt"
    case remove = "rm_txt"
    case low = "ch_txt"
}

struct HtmlStyle {
    static let kAddColor = "green"
    static let kRmColor = "red"
    static let kModColor = "blue"
    static let kLowColor = "gray"
    static let kTextColor = "white"
    static let kStatisticCellWidth = "45px"
    static let kStatisticCellHeight = "40px"
    static let kBodyFontSize = "15px"
}

extension FileHandle {

    private func write(_ str: String) {
        if let data = (str + "\n").data(using: .utf8) {
            write(data)
        }
    }

    func writeHTMLHead() {
        let data = """
<html>
<head>
    <meta charset="UTF-8"/>
    <style>
        table {width:100%; background-color: white; table-layout: fixed; word-wrap: break-word;}
        tr:nth-child(odd) {background: #e6e6e6;}
        tr.head {background: #ffe0b3; height: \(HtmlStyle.kStatisticCellHeight);}
        tr.head_low {background: #cccccc; height: \(HtmlStyle.kStatisticCellHeight);}
        th:nth-child(odd) {background: #cccccc;}
        th:nth-child(even) {background: #b3b3b3;}
        td.no {text-align:right;}
        td.add_status {background: \(HtmlStyle.kAddColor); text-align: center; color: white;}
        td.rm_status {background: \(HtmlStyle.kRmColor); text-align: center; color: white;}
        td.mod_status {background: \(HtmlStyle.kModColor); text-align: center; color: white;}
        td.ch_status {background: \(HtmlStyle.kLowColor); text-align: center; color: white;}
        td.add_txt {color: \(HtmlStyle.kAddColor);}
        td.rm_txt {color: \(HtmlStyle.kRmColor);}
        td.mod_txt {color: \(HtmlStyle.kModColor);}
        td.ch_txt {color: \(HtmlStyle.kLowColor);}
        td.git_add {color: \(HtmlStyle.kAddColor); border: 1px solid \(HtmlStyle.kAddColor); width: \(HtmlStyle.kStatisticCellWidth); text-align: center; background: none;}
        td.git_mod {color: \(HtmlStyle.kModColor); border: 1px solid \(HtmlStyle.kModColor); width: \(HtmlStyle.kStatisticCellWidth); text-align: center; background: none;}
        td.git_rm {color: \(HtmlStyle.kRmColor); border: 1px solid \(HtmlStyle.kRmColor); width: \(HtmlStyle.kStatisticCellWidth); text-align: center; background: none;}
        td.add_num {color: white; width: \(HtmlStyle.kStatisticCellWidth); text-align: center; background: \(HtmlStyle.kAddColor);}
        td.rm_num {color: white; width: \(HtmlStyle.kStatisticCellWidth); text-align: center; background: \(HtmlStyle.kRmColor);}
        td.mod_num {color: white; width: \(HtmlStyle.kStatisticCellWidth); text-align: center; background: \(HtmlStyle.kModColor);}
        td.low_num {color: white; width: \(HtmlStyle.kStatisticCellWidth); text-align: center; background: \(HtmlStyle.kLowColor);}
        td.num_head {color: black; width: \(HtmlStyle.kStatisticCellWidth); text-align: center; background: #ffe0b3;}
        a.control {text-decoration: none;}
        a.control:link {color: black;}
        a.control:visited {color: black;}
        a.control:hover {color: white; text-shadow: 1px 1px black;}
        a.control:active {color: white; text-shadow: 0px 0px white;}
    </style>
    <script>
        function show(className) {
            var items = document.getElementsByClassName(className);
            for (var index = 0; index < items.length; index++) {
                items[index].style.display = "";
            }
            document.getElementById(className + "show").style.display = "none";
            document.getElementById(className + "hide").style.display = "";
        }
        function hide(className) {
            var items = document.getElementsByClassName(className);
            for (var index = 0; index < items.length; index++) {
                items[index].style.display = "none";
            }
            document.getElementById(className + "show").style.display = "";
            document.getElementById(className + "hide").style.display = "none";
        }
        function showAll(count) {
            for (var index = 0; index < count; index++) {
                show("filerow" + index)
            }
        }
        function hideAll(count) {
            for (var index = 0; index < count; index++) {
                hide("filerow" + index)
            }
        }
        function openInNewTab(url) {
              var win = window.open("file://" + document.getElementById("basepath").value + "/" + url, '_blank');
              win.focus();
        }
    </script>
</head>
"""
        write(data)
    }

    func writeHTMLBodyHead(basePath: String, totalAdd: UInt, totalRemove: UInt, totalMod: UInt, totalLowM: UInt,
                           totalGitAdd: UInt, totalGitRemove: UInt, filesCount: Int, version: String) {
        let data = """
<body style="font-family: monospace; font-size: \(HtmlStyle.kBodyFontSize); background-color: #e6e6e6;">
    <h1 id="top">Git Diff LOC Count</h1>
    Version \(version)
    <p>Base path: <input type="text" value="\(basePath)" style="width: 95%;" id="basepath"/></p>
    <p><b>Summary:</b></p>
    <ul>
        <li>Checked files: \(filesCount).</li>
        <li>Added text lines: \(totalGitAdd). Removed text lines: \(totalGitRemove).</li>
        <li><font color="\(HtmlStyle.kAddColor)">Added LOCs: \(totalAdd).</font> <font color="\(HtmlStyle.kRmColor)">Removed LOCs: \(totalRemove).</font> <font color="\(HtmlStyle.kModColor)">Modified LOCs: \(totalMod).</font> <font color="\(HtmlStyle.kLowColor)">Low meaning LOCs: \(totalLowM).</font></li>
    </ul>
    <hr/>
    <p>
        <a href="javascript:showAll(\(filesCount));" class="control">[Expand All]</a>
        <a href="javascript:hideAll(\(filesCount));" class="control">[Collapse All]</a>
    </p>
"""
        write(data)
    }

    func writeTableHead(oldBranch: String, newBranch: String) {
        let data = """
    <table>
    <tr>
        <th style="width: 25px;"></th>
        <th style="width: 35px;">Line</th>
        <th>\(oldBranch)</th>
        <th style="width: 35px;">Line</th>
        <th>\(newBranch)</th>
    </tr>
"""
        write(data)
    }

    func writeFileHeadRow(path: String, addN: UInt, rmN: UInt, modN: UInt, lowN: UInt, gAddN: UInt, gRmN: UInt, index: Int) {
        let data = """
    <tr id="filerow\(index)" class="head">
        <td style="text-align:center;">
            <a href="#filerow\(index)" onclick="show('filerow\(index)');" id="filerow\(index)show" class="control">\(index + 1)<br/>▶</a>
            <a href="#filerow\(index)" onclick="hide('filerow\(index)');" id="filerow\(index)hide" class="control" style="display:none;">\(index + 1)<br/>▼</a>
        </td>
        <td colspan=4>
            <table style="border-collapse: collapse;">
            <tr class="head">
                <td><a href="javascript:openInNewTab('\(path)');">\(path)</a><br/></td>
                <td class="num_head">LOC:</td>
                <td class="add_num">+\(addN)</td>
                <td class="rm_num">-\(rmN)</td>
                <td class="mod_num">\(modN)</td>
                <td class="low_num">\(lowN)</td>
                <td class="num_head">Git:</td>
                <td class="git_add">+\(gAddN)</td>
                <td class="git_rm">-\(gRmN)</td>
            </tr>
            </table>
        </td>
    </tr>
"""
        write(data)
    }

    func writeDiffCodeLine(index: Int, statusClass: HtmlStatusClass, statusContent: String,
                           oldNum: UInt?, oldClass: HtmlTextClass, oldContent: String,
                           newNum: UInt?, newClass: HtmlTextClass, newContent: String) {
        let oldN: String
        if let num = oldNum {
            oldN = "\(num)"
        } else {
            oldN = ""
        }
        let newN: String
        if let num = newNum {
            newN = "\(num)"
        } else {
            newN = ""
        }

        let data = """
    <tr style="display:none;" class="filerow\(index)">
        <td class="\(statusClass.rawValue)">\(statusContent)</td>
        <td class="no">\(oldN)</td>
        <td class="\(oldClass.rawValue)">\(oldContent)</td>
        <td class="no">\(newN)</td>
        <td class="\(newClass.rawValue)">\(newContent)</td>
    </tr>
"""
        write(data)
    }

    func writeFileMovedHead(fileCount: Int, index: Int) {
        let data = """
    <tr class="head_low" id="filerow\(index)">
        <td style="text-align:center;">
            <a href="#filerow\(index)" onclick="show('filerow\(index)');" id="filerow\(index)show" class="control">▶</a>
            <a href="#filerow\(index)" onclick="hide('filerow\(index)');" id="filerow\(index)hide" class="control" style="display:none;">▼</a>
        </td>
        <td colspan=4>
            Moved files: \(fileCount)<br/>
        </td>
    </tr>
"""
        write(data)
    }

    func writeUncheckedFileHead(fileCount: Int, index: Int, addN: UInt, modN: UInt, rmN: UInt) {
        let data = """
    <tr class="head_low" id="filerow\(index)">
        <td style="text-align:center;">
            <a href="#filerow\(index)" onclick="show('filerow\(index)');" id="filerow\(index)show" class="control">▶</a>
            <a href="#filerow\(index)" onclick="hide('filerow\(index)');" id="filerow\(index)hide" class="control" style="display:none;">▼</a>
        </td>
        <td colspan=4>
            <table style="border-collapse: collapse;">
            <tr class="head_low">
                <td>Unchecked files: \(fileCount)</td>
                <td class="git_add">+\(addN)</td>
                <td class="git_mod">\(modN)</td>
                <td class="git_rm">-\(rmN)</td>
            </tr>
            </table>
        </td>
    </tr>
"""
        write(data)
    }

    func writeTermination(author: String, copyright: String, extensions: [String], filterPaths: [String], excludePaths: [String]) {
        let data = """
    </table>
    <p style="text-align:center;"><a href="#top" class="control">▲ TOP ▲</a></p>
    <p id="filerow-1">
        <a href="#filerow-1" onclick="show('filerow-1');" id="filerow-1show" class="control"><b>Rules</b> ▶</a>
        <a href="#filerow-1" onclick="hide('filerow-1');" id="filerow-1hide" class="control" style="display:none;"><b>Rules</b> ▼</a>
    </p>
    <ul class="filerow-1" style="display:none;">
    <li>
        Low meaning lines:
        <ul>
        <li>Comment (<i>// Single line comment</i>, <i>/* Multi-lines comment */</i>).</li>
        <li>Empty.</li>
        <li>Containing only characters: &quot;{}()[] &quot;</li>
        </ul>
    </li>
    <li>
        Modified line:
        <ul>
        <li>from meaning to low meaning: counted as removed line.</li>
        <li>from low meaning to meaning: counted as added line.</li>
        </ul>
    </li>
"""
        write(data)
        if extensions.count > 0 {
            write("    <li>")
            write("        Check files having extension:")
            write("        <ul>")
            for ext in extensions {
                write("        <li><i>\(ext)</i></li>")
            }
            write("        </ul>")
            write("    </li>")
        }
        if filterPaths.count > 0 {
            write("    <li>")
            write("        Only check files in folder &amp; subfolder:")
            write("        <ul>")
            for path in filterPaths {
                write("        <li><i>\(path)</i></li>")
            }
            write("        </ul>")
            write("    </li>")
        }
        if excludePaths.count > 0 {
            write("    <li>")
            write("        Not check files in folder &amp; subfolder:")
            write("        <ul>")
            for path in excludePaths {
                write("        <li><i>\(path)</i></li>")
            }
            write("        </ul>")
            write("    </li>")
        }

        write("    </ul>")
        if author.count > 0 {
            write("    <p style=\"text-align:center;\">Created by \(author) at \(formatDate(format: kCreatedDateFormat)).</p>")
        }
        if copyright.count > 0 {
            write("    <p style=\"text-align:center;\">Copyright © \(formatDate(format: "y")) \(copyright). All rights reserved.</p>")
        }
        write("</body>")
        write("</html>")
    }

}
