//
//  JOThreadWordsPuzzle.swift
//  threadword
//
//  Created by Joshua Oldenburg on 6/18/14.
//  Copyright (c) 2014 Joshua Oldenburg. All rights reserved.
//

import Foundation

class JOThreadWordsPuzzle {
	let lines: Array<String>
	let columns: Array<String> = []
	let width: Int = 0
	let height: Int = 0

	init(level: Array<String>) {
		lines = level.filter({ return countElements($0) > 0 })
		assert(lines.count > 0, "The level must have letters!")
		columns = self._getColumns(lines)
		width = self._lineLength(lines)
		height = self._lineLength(columns)
		assert(width > 0, "The lines must have the same number of letters!");
		assert(height > 0 , "The lines must have the same number of letters!");
	}

	func solve() -> Array<String> {
		return self.solve(JOUtil.isWord)
	}

	func solve(isWord: String -> Bool) -> Array<String> {
		var ret = Array<Array<String>>();
		
		for var idx = 0; idx < height; idx++ {
			let results: String[] = _findContiguous(0, idx: idx).map({ return self.columns[0][idx] + $0 })
			ret.append(results.filter(isWord))
		}
		
		return JOFlatten(ret) as String[]
	}
	
	func _findContiguous(col: Int, idx: Int) -> String[] {
		var indexes = [
			idx - 1,
			idx,
			idx + 1,
		]
		indexes = indexes.filter({ return $0 >= 0 && $0 < self.height })
		var result = String[]()
		for index in indexes {
			let newCol = col + 1
			let char = self.columns[newCol][index]
			if (self.width - 1 == newCol) {
				result += char
			} else {
				let contiguous = self._findContiguous(newCol, idx: index)
				result += contiguous.map({ return char + $0 })
			}
		}
		return JOFlatten(result) as String[]
	}

	func _getColumns(rows: String[]) -> String[] {
		var ret = String[]()

		for row in rows {
			for var charIdx = 0; charIdx < countElements(row); charIdx++ {
				let char = row[charIdx]
				if (charIdx >= ret.count) {
					ret.insert("", atIndex: charIdx)
				}
				ret[charIdx] += char
			}
		}
		
		return ret
	}
	
	func _lineLength(lines: String[]) -> Int {
		let lengths = lines.bridgeToObjectiveC().valueForKeyPath("@distinctUnionOfObjects.length") as Int[] // Easiest way to do _.uniq I could think of
		if (lengths.count > 1) {
			return -1
		} else {
			return lengths[0]
		}
	}
}

extension String { // https://stackoverflow.com/questions/24092884
	subscript (i: Int) -> String { // "abcde"[2] == "c"
		return String(Array(self)[i])
	}
	
	subscript (r: Range<Int>) -> String { // "abcde"[0...2] == "abc"
		var start = advance(startIndex, r.startIndex)
		var end = advance(startIndex, r.endIndex)
		return substringWithRange(Range(start: start, end: end))
	}
}

func JOFlatten(array: AnyObject[]) -> AnyObject[] { // https://github.com/ankurp/Dollar.swift/blob/a0072d3/Dollar/Dollar.swift#L350-L364
	var resultArr: AnyObject[] = []
	for elem: AnyObject in array {
		if let val = elem as? AnyObject[] {
			resultArr += JOFlatten(val)
		} else {
			resultArr += elem
		}
	}
	return resultArr
}
