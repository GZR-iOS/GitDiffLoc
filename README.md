# GitDiffLoc

My personal Mac OS X Terminal tool to count line of codes (LOC) of Swift (also ObjC) based on Git Diff, and export the result to HTML file for reporting.

Development environment: Mac OS X 10.14.4.

## Features:

- Everything is based on Git Diff.
- Count LOC only, ignore low meaningful lines: comment, empty, or line containing special characters.
- Try to detect added lines, removed lines, modified lines, and moving Files.
- Export result to HTML.

## How it counts LOC:

- Low meaningful line is line becoming empty after:
  - Trimming spaces.
  - Remove comment part (`// comment to the end of line`)
  - Remove block comment `/* multi-lines comment */` (risk: if block comment begins (`/*`) somewhere out of Git Diff context so the line still be counted as a LOC.)
  - Trimming characters in `{}()[]`.
- Using GIT Diff, it detects added lines (lines not having equivalent source lines), remove lines (lines not having equivalent target lines).
- Line which has both source & target versions, is:
  - modified line if both source & target versions are not low meaningful lines.
  - added line if source version is low meaningful line.
  - removed line if target version is low meaningful line.

## Source code:

Dependencies:

- [libgit2/objective-git](https://github.com/libgit2/objective-git): Lib GIT for ObjC.
- [tonyarnold/Differ](https://github.com/tonyarnold/Differ): check different of modified lines.

In this repository, I added everythings (including the above library source codes).

If you get problems while building `objective-git `, please check its own README. My notes:

- Install `cmake` [cmake.org](https://cmake.org/download/), default into `/Applications`. Use this tool to build **libgit2** (subproject **ObjectiveGitFramework**, target **libgit2**, section **Build Phases**).
- Install library `libssh2` if needed: I used [MacPorts](https://www.macports.org) => then check these paths: `/opt/local/lib/libcrypto.a`, `/opt/local/lib/libssl.a`, `/opt/local/lib/libiconv.a`. If your paths are different:
  - Re-make link file `objective-git/External/libcrypto.a` và `objective-git/External/libssl.a` to the right paths.
  - In subproject **ObjectiveGitFramework**, target **ObjectiveGit-Mac**, section **Link Binary with libraries**, remove & add again `libiconv`.

## Usage:

In Terminal, run

```
GitDiff
```

This command prints the usage description.

Full description:

In Terminal, move (`cd`) to your project root folder (where we can find `.git` folder).

```
GitDiff <old local branch name> <new local branch name> [-x<excluded path> ...] [-X<excluded list input file>] [-f<filter path> ...] [-F<filter list input file>] [-e<file extension> ...] [-a<Author>] [-c<Copyright>] [-hctx] [outout file]
```

- `<>` is required.
- `[]` is optional.
- `...`: you can repeat this option.
- `-x`: excluded path -> not check files in this folder & its subfolders.
- `-X`: path to a text file which contains excluded paths (each excluded path on 1 line).
- `-f`: check only this file.
- `-F`: path to a text file which contains the list of files to check only (each path on 1 line).
- `-e`: file extension to check. If you don't specify, default it checks only `swift`, `h`, `m`. If you want check all files, specify single `-e` (without extension).
- `-a`: author name of HTML output file. Default is your Mac OS X full name. Give single `-a` to ignore author name.
- `-c`: organization name for HTML output file copyright.
- `-hctx`: hide GIT context lines (show only Git edited lines).
- Last argument is always the output file. If you does not specify, it prints out LOC count only.

**Example**:

`GitDiff master develop -xPods -eswift -aSoleilPQD "-cGMO-Z.com RunSystem" diff.html`

Count LOC of Git Diff from `master` to `develop`, ignore files in folder `Pods`, export result into `diff.html` using author name `SoleilPQD` & copyright `GMO-Z.com RunSystem` (because `GMO-Z.com RunSystem` contains space so we have to push it in `""`).

## Author:

DươngPQ

Copyright © 2018-2019 GMO-Z.com RunSystem. All rights reserved.

License: See file [LICENSE](LICENSE).

