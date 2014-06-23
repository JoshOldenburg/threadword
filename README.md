threadword
=========
This is a solver for the Thread Words game for Kindle (http://www.amazon.com/Thread-Words/dp/B004Y51PW4), written in Swift and utilizing the system dictionary. This is more or less a direct port of [JoshTheGeek/node-wordfinder](https://github.com/JoshTheGeek/node-wordfinder) from JavaScript to Swift, ported for speed and easier access to the OS X system dictionary.

This is a simple CLI at the moment, but may later grow into an iOS app.

## Installation
Download the project and build it yourself with Xcode 6, or get the binary from the releases tab above.

## Usage
```
threadword matzsud crrioes oossnte lattagh judders # the random letters are the lines of the puzzle, in order
# => outputs the solutions, based on the dictionary

threadword --prefix o <level> # outputs all possible combinations starting with o (not limited to the dictionary)

threadword --all <level> # outputs all possible combinations
```

## License
Copyright 2014 Josh Oldenburg, released under the MIT license
