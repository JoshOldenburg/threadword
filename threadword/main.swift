//
//  main.swift
//  threadword
//
//  Created by Joshua Oldenburg on 6/18/14.
//  Copyright (c) 2014 Joshua Oldenburg. All rights reserved.
//

import Foundation

let puzzle = JOThreadWordsPuzzle(level: [
/*	"malgmrt",
	"corveos",
	"sunnisn",
	"trtdrng",
	"fausged",*/
	"toeing",
	"ritlws",
	"vabted",
	"sooiae",
	"hcrubs",
])

println(puzzle.solve().description)
