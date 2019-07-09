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

extension FileHandle {

    private func write(_ str: String) {
        if let data = (str + "\n").data(using: .utf8) {
            write(data)
        }
    }

    func writeHTMLHead(total: Int) {
        let data = """
<html>
<head>
    <meta charset="UTF-8"/>
    <style>
        table {
            width: 100%;
            background-color: white;
            table-layout: fixed;
            word-wrap: break-word;
        }
        tr:nth-child(odd) {
            background: #e6e6e6;
        }
        tr.head {
            background: #ffe0b3;
            height: 40px;
        }
        tr.head_low {
            background: #cccccc;
            height: 40px;
        }
        th:nth-child(odd) {
            background: #cccccc;
        }
        th:nth-child(even) {
            background: #b3b3b3;
        }
        td.no {
            text-align:right;
        }
        td.add_status {
            background: green;
            text-align: center;
            color: white;
        }
        td.rm_status {
            background: red;
            text-align: center;
            color: white;
        }
        td.mod_status {
            background: blue;
            text-align: center;
            color: white;
        }
        td.ch_status {
            background: gray;
            text-align: center;
            color: white;
        }
        td.ch_status_ctx {
            background: #afafaf;
            text-align: center;
            color: white;
        }
        td.add_txt {
            color: green;
        }
        td.rm_txt {
            color: red;
        }
        td.mod_txt {
            color: blue;
        }
        td.ch_txt {
            color: gray;
        }
        td.ch_txt_ctx {
            color: #afafaf;
        }
        td.git_add {
            color: green;
            border: 1px solid green;
            width: 45px;
            text-align: center;
            background: none;
        }
        td.git_mod {
            color: blue;
            border: 1px solid blue;
            width: 45px;
            text-align: center;
            background: none;
        }
        td.git_rm {
            color: red;
            border: 1px solid red;
            width: 45px;
            text-align: center;
            background: none;
        }
        td.add_num {
            color: white;
            width: 45px;
            text-align: center;
            background: green;
        }
        td.rm_num {
            color: white;
            width: 45px;
            text-align: center;
            background: red;
        }
        td.mod_num {
            color: white;
            width: 45px;
            text-align: center;
            background: blue;
        }
        td.low_num {
            color: white;
            width: 45px;
            text-align: center;
            background: gray;
        }
        td.num_head {
            color: black;
            width: 45px;
            text-align: center;
            background: #ffe0b3;
        }
        a.control {
            text-decoration: none;
        }
        a.control:link {
            color: black;
        }
        a.control:visited {
            color: black;
        }
        a.control:hover {
            color: white;
            text-shadow: 1px 1px black;
        }
        a.control:active {
            color: white;
            text-shadow: 0px 0px white;
        }
        label:hover {
            color: white;
            text-shadow: 1px 1px black;
        }
        label:active {
            color: white;
            text-shadow: 0px 0px white;
        }
        span.diff {
            background: yellow;
        }
    </style>
    <script>
        var totalSections = \(total);
        var visibleStatuses = new Array(totalSections);
        for (var index = 0; index < totalSections; index++) {
            visibleStatuses[index] = false;
        }

        function displaySection(section, visible) {
            var className = "filerow" + section;
            var items = document.getElementsByClassName(className);
            for (item of items) {
                item.style.display = visible ? "" : "none";
            }
            document.getElementById(className + "show").style.display = visible ? "none" : "";
            document.getElementById(className + "hide").style.display = visible ? "" : "none";

            var ctxVisible = document.getElementById("context_visible").checked;
            className = className + "ctx";
            items = document.getElementsByClassName(className);
            for (item of items) {
                item.style.display = (visible && ctxVisible) ? "" : "none";
            }
            visibleStatuses[section] = visible;
        }

        function displayAll(visible) {
            for (var index = 0; index < totalSections; index++) {
                displaySection(index, visible);
            }
        }

        function openInNewTab(url) {
              var win = window.open("file://" + document.getElementById("basepath").value + "/" + url, '_blank');
              win.focus();
        }

        function contextVisibleOnCheck() {
            for (var index = 0; index < totalSections; index++) {
                if (visibleStatuses[index]) {
                    displaySection(index, true);
                }
            }
        }

        function spaceVisibleOnCheck() {
            var visible = document.getElementById("space_visibility").checked;
            var items = document.getElementsByClassName("space_visible");
            for (item of items) {
                item.style.display = visible ? "" : "none";
            }
            items = document.getElementsByClassName("space_hidden");
            for (item of items) {
                item.style.display = visible ? "none" : "";
            }
        }

        function differenceVisibleOnCheck() {
            var visible = document.getElementById("difference_visibility").checked;
            var items = document.getElementsByClassName("diff");
            for (item of items) {
                item.style.background = visible ? "yellow" : "none";
            }
        }

        function copyFilePath(index) {
            var txt = document.getElementById("filepath" + index).innerText;
            txt = txt.substring(0, txt.length - 3);
            var board = document.getElementById("clipboard");
            board.value = txt;
            board.select();
            document.execCommand("copy");
        }
    </script>
</head>
"""
        write(data)
    }

    func writeHTMLBodyHead(basePath: String, totalAdd: UInt, totalRemove: UInt, totalMod: UInt, totalLowM: UInt,
                           totalGitAdd: UInt, totalGitRemove: UInt, filesCount: Int, version: String) {
        let data = """
<body style="font-family: monospace; font-size: 15px; background-color: #e6e6e6;">
    <h1 id="top">Git Diff LOC Count</h1>
    Version \(version)
    <p>Base path: <input type="text" value="\(basePath)" style="width: 95%;" id="basepath"/></p>
    <p><b>Summary:</b></p>
    <ul>
        <li>Checked files: \(filesCount).</li>
        <li>Added text lines: \(totalGitAdd). Removed text lines: \(totalGitRemove).</li>
        <li><font color="green">Added LOCs: \(totalAdd).</font> <font color="red">Removed LOCs: \(totalRemove).</font> <font color="blue">Modified LOCs: \(totalMod).</font> <font color="gray">Low meaning LOCs: \(totalLowM).</font></li>
    </ul>
    <hr/>
    <p>
        <a href="javascript:displayAll(true);" class="control">[Expand All]</a>
        <a href="javascript:displayAll(false);" class="control">[Collapse All]</a>
        <label><input type="checkbox" unchecked id="context_visible" onclick="contextVisibleOnCheck();"/> Context lines visible</label>
        <label><input type="checkbox" checked id="space_visibility" onclick="spaceVisibleOnCheck();"/> Spaces visible</label>
        <label><input type="checkbox" checked id="difference_visibility" onclick="differenceVisibleOnCheck();"/> Difference visible</label>
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
            <a href="#filerow\(index)" onclick="displaySection(\(index), true);" id="filerow\(index)show" class="control">\(index + 1)<br/>▶</a>
            <a href="#filerow\(index)" onclick="displaySection(\(index), false);" id="filerow\(index)hide" class="control" style="display:none;">\(index + 1)<br/>▼</a>
        </td>
        <td colspan=4>
            <table style="border-collapse: collapse;">
            <tr class="head">
                <td id="filepath\(index)"><a href="javascript:openInNewTab('\(path)');">\(path)</a> <a href="javascript:copyFilePath(\(index));" class="control">📋</a></td>
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

    private func makeHTMLContentTrueSpace(_ input: String) -> String {
        return input.replacingOccurrences(of: "·", with: "&ensp;")
    }

    func writeDiffCodeLine(index: Int, statusClass: HtmlStatusClass, statusContent: String,
                           oldNum: UInt?, oldClass: HtmlTextClass, oldContent: String,
                           newNum: UInt?, newClass: HtmlTextClass, newContent: String, isContext: Bool) {
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
        let oldContentSp = makeHTMLContentTrueSpace(oldContent)
        let newContentSp = makeHTMLContentTrueSpace(newContent)
        let data = """
    <tr style="display:none;" class="filerow\(index)\(isContext ? "ctx" : "")">
        <td class="\(statusClass.rawValue + (isContext ? "_ctx" : ""))">\(statusContent)</td>
        <td class="no">\(oldN)</td>
        <td class="\(oldClass.rawValue + (isContext ? "_ctx" : ""))"><span class=\"space_visible\">\(oldContent)</span><span class=\"space_hidden\" style=\"display:none;\">\(oldContentSp)</span></td>
        <td class="no">\(newN)</td>
        <td class="\(newClass.rawValue + (isContext ? "_ctx" : ""))"><span class=\"space_visible\">\(newContent)</span><span class=\"space_hidden\" style=\"display:none;\">\(newContentSp)</span></td>
    </tr>
"""
        write(data)
    }

    func writeFileMovedHead(fileCount: Int, index: Int) {
        let data = """
    <tr class="head_low" id="filerow\(index)">
        <td style="text-align:center;">
            <a href="#filerow\(index)" onclick="displaySection(\(index), true);" id="filerow\(index)show" class="control">▶</a>
            <a href="#filerow\(index)" onclick="displaySection(\(index), false);" id="filerow\(index)hide" class="control" style="display:none;">▼</a>
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
            <a href="#filerow\(index)" onclick="displaySection(\(index), true);" id="filerow\(index)show" class="control">▶</a>
            <a href="#filerow\(index)" onclick="displaySection(\(index), false);" id="filerow\(index)hide" class="control" style="display:none;">▼</a>
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
        write("<input type=\"text\" id=\"clipboard\" style=\"opacity:0;\"/>")
        write("</body>")
        write("</html>")
    }

}
