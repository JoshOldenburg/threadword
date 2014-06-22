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
parser.registerOption("file", shortcut: 102 /* f */, requirement: GBValueRequired)

var options = Dictionary<String, AnyObject>()
var lines = Array<String>()

func _parseOption(flags: GBParseFlags, argument: String?, value: AnyObject?, stop: CMutablePointer<ObjCBool>?) {
	switch flags {
	case GBParseFlagOption:
		options[argument!] = value
	case GBParseFlagArgument:
//		if let strValue: NSString = value! as? NSString {
//			lines.append(String(strValue))
//		}
//		lines += String((value! as NSString).copy() as NSString)
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

println("Solving puzzle:")
for line in lines {
	println(" \(line)")
}

let puzzle = JOThreadWordsPuzzle(level: lines)

let allWords = puzzle.solve()
var solution: String[]
if options["file"] || options["prefix"] {
//	solution = allWords.filter() { word -> Bool in
//		if let prefix: String = options["prefix"] as String {
//			if word.
//			return false
//		}


//		return true
//	}
	solution = allWords
} else {
	solution = allWords.filter() { JOUtil.isWord($0) }
//	solution = allWords.filter() { $0.bridgeToObjectiveC().hasPrefix("o") && $0.bridgeToObjectiveC().hasSuffix("s") }
}
//println(lines.description)
//println(lines[0])
println("All words, by location: \(solution.description)")
println("All words, alphabetically: \(sort(solution) { $0 < $1 })")
println("\(solution.count) solutions found")
