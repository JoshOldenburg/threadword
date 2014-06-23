//
//  main.swift
//  threadword
//
//  Created by Joshua Oldenburg on 6/18/14.
//  Copyright (c) 2014 Joshua Oldenburg. All rights reserved.
//

import Foundation

let parser = GBCommandLineParser()
parser.registerOption("prefix", shortcut: 112 /* p */, requirement: GBValueRequired)
//parser.registerOption("file", shortcut: 102 /* f */, requirement: GBValueRequired)
parser.registerOption("all", shortcut: 61 /* a */, requirement: GBValueNone)

var options = Dictionary<String, AnyObject>()
var lines = Array<String>()

func _parseOption(flags: GBParseFlags, argument: String?, value: AnyObject?, stop: CMutablePointer<ObjCBool>?) {
	switch flags {
	case GBParseFlagOption:
		options[argument!] = value
	case GBParseFlagArgument:
		if let strValue: String = value? as? NSString {
			if (countElements(strValue) > 0) {
				lines += strValue
			}
		}
	case GBParseFlagMissingValue:
		println("Error: option \(argument) requires a value")
		exit(2)
	case GBParseFlagUnknownOption:
		println("Error: uknown option \(argument)")
		exit(2)
	default:
		println("Error: this should never happen - unknown GBParseFlags \(flags)")
		exit(1)
	}
}

parser.parseOptionsUsingDefaultArgumentsWithBlock(_parseOption)

if lines.count <= 1 {
	println("Error: you must give a puzzle to solve!")
	exit(2)
}

println("Solving puzzle:")
for line in lines {
	println(" \(line)")
}

let puzzle = JOThreadWordsPuzzle(level: lines)

let allWords = puzzle.solve()
var solution: String[]
let prefix: String? = options["prefix"]? as? String
let showAllWords: Bool = (options["all"] != nil)
let filePath: String? = options["file"]? as? String
var fileWords: String[]

/*if filePath != nil {
	let fileData: String? = NSString.stringWithContentsOfFile(filePath) as? String
	if fileData == nil {
		println("The specified file did not exist!")
		exit(3)
	} else {
		fileWords = fileData!.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
	}
}*/

if showAllWords { // --all
	solution = allWords
} else if prefix != nil || filePath != nil { // --prefix and/or --file
	solution = allWords.filter() { word -> Bool in
		if prefix != nil && !word.bridgeToObjectiveC().hasPrefix(prefix) {
			return false
		}

		// Never runs, is disabled
		if fileWords != nil && !JOUtil.isFound(JOUtil.binarySearchArray(fileWords, forObject:word)) {
			return false
		}

		return true
	}
} else {
	solution = allWords.filter() { JOUtil.isWord($0) }
}
println("All words, by location: \(solution.description)")
println("All words, alphabetically: \(sort(solution) { $0 < $1 })")
println("\(solution.count) solutions found")
