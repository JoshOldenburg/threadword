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
		lines += String((value! as NSString).copy() as NSString)
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

var solution: String[]
if options["file"] || options["prefix"] {
	solution = puzzle.solve({ return $0 == "" })
} else {
	solution = puzzle.solve()
}
println(lines.description)
println(lines[0])
println(solution.description)
println(solution.count)
