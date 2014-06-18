//
//  main.swift
//  threadword
//
//  Created by Joshua Oldenburg on 6/18/14.
//  Copyright (c) 2014 Joshua Oldenburg. All rights reserved.
//

import Foundation

/*let parser = GBCommandLineParser()
parser.registerOption("prefix", shortcut: 112 /* p */, requirement: GBValueRequired)
parser.registerOption("file", shortcut: 102 /* f */, requirement: GBValueRequired)

parser.parseOptionsUsingDefaultArgumentsWithBlock({ // (flags: GBParseFlags, argument: String, value: AnyObject, stop) 
	return
}()) */

let puzzle = JOThreadWordsPuzzle(level: [
/*	"malgmrt",
	"corveos",
	"sunnisn",
	"trtdrng",
	"fausged",*/
/*	"toeing",
	"ritlws",
	"vabted",
	"sooiae",
	"hcrubs",*/
	"pepries",
	"dorohod",
	"tancsnt",
	"supaees",
	"ctrryrd",
])

let solution = puzzle.solve()
println(solution.description)
println(solution.count)
