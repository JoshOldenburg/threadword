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
	}
	
	func solve() -> Array<String> {
		var ret = Array<Array<String>>();
		
		for var idx = 0; idx < height; idx++ {
			let results: String[] = _findContiguous(0, idx: idx).map({ return self.columns[0][idx] + $0 })
			ret.append(results.filter({ return self._isWord($0) }))
		}
		
		func _comment() {
			/*
			exports.solveThreadWord = function(level) {
			if (!level) return false;
			var lines = _.filter(level.split('\n'), function(item) { return item && item.length != 0; });
			if (!lines) return false;
			var length = _lineLength(lines);
			if (!length) return false;
			var columns = _getColumns(lines);
			var height = _lineLength(columns);
			if (!length) return false;
			var ret = [];
			
			function _findContiguous(col, idx) {
			return _.chain([
			idx - 1,
			idx,
			idx + 1,
			]).filter(function(index) {
			return index >= 0 && index < height;
			}).map(function(index) {
			var char = columns[col + 1][index];
			if (col == length - 2) return [char];
			else return _.map(_findContiguous(col + 1, index), function(item) {
			return char + item;
			});
			}).flatten().value();
			}
			
			for (var i = 0; i < height; i++) {
			var results = _findContiguous(0, i);
			results = _.chain(results).map(function(item) {
			return columns[0][i] + item;
			}).filter(function(item) {
			return exports.checkToDictionary(item);
			}).value();
			ret.push(results);
			}
			
			return _.flatten(ret);
			}
			
			
			*/
		}
		
		return JOFlatten(ret) as String[]
	}
	
	func _findContiguous(col: Int, idx: Int) -> String[] {
//		println("-> _findContiguous(col: \(col), idx: \(idx))")
		var indexes = [
			idx - 1,
			idx,
			idx + 1,
		]
		indexes = indexes.filter({ return $0 >= 0 && $0 < self.height })
		var result = String[]()
		for index in indexes {
//			println(" - _findContiguous(col: \(col), idx: \(idx)) \(index)")
			let newCol = col + 1
			let char = self.columns[newCol][index]
			if (self.width - 1 == newCol) {
				result += char
			} else {
//				println(" - calling _findContiguous(col: \(newCol), idx: \(index))")
				let contiguous = self._findContiguous(newCol, idx: index)
				result += contiguous.map({ return char + $0 })
			}
		}
//		let result = indexes.map({ (index: Int) -> String[] in
//			let char = self.columns[col + 1][index]
//			if (col == self.width - 2) {
//				return ["💩"]
//			} else {
//				let contiguous = self._findContiguous(col + 1, idx: index)
//				return contiguous.map({ return char + $0 })
//			}
//		})
//		println("<- _findContiguous(col: \(col), idx: \(idx))")
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
	
	func _isWord(word: String) -> Bool {
//		return true
		return JOUtil.isWord(word)
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
