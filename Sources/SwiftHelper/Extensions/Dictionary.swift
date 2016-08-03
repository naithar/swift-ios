//  Copyright (c) 2016 Sergey Minakov
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the Software
//  is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
//  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
//  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

public extension Dictionary {

    public mutating func append(_ other: Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}

public func + <KeyType, ValueType>(first: Dictionary<KeyType, ValueType>,
        second: Dictionary<KeyType, ValueType>) -> Dictionary<KeyType, ValueType> {
    var result = first
    result.append(second)
    return result
}

public func += <KeyType, ValueType> (first: inout Dictionary<KeyType, ValueType>,
         second: Dictionary<KeyType, ValueType>) {
    first.append(second)
}

public func += <KeyType, ValueType> (first: inout Dictionary<KeyType, ValueType>,
         value: (key: KeyType, value: ValueType?)) {
    first[value.key] = value.value
}
