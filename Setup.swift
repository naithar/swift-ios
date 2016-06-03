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


infix operator ~> {}
public func ~> <T> (value: T?,
                @noescape closure: (inout item: T) -> ()) -> T? {
    guard var returnValue = value else { return nil }
    closure(item: &returnValue)
    return returnValue
}

public func ~> <T1, T2> (value: (T1?, T2?),
                @noescape closure: (inout first: T1, inout second: T2) -> ()) -> (T1?, T2?) {
    guard var first = value.0,
        var second = value.1 else { return (nil, nil) }

    closure(first: &first, second: &second)
    return (first, second)
}

public func ~> <T1, T2, T3> (value: (T1?, T2?, T3?),
                @noescape closure: (inout first: T1, inout second: T2, inout third: T3) -> ()) -> (T1?, T2?, T3?) {
    guard var first = value.0,
        var second = value.1,
        var third = value.2 else { return (nil, nil, nil) }

    closure(first: &first, second: &second, third: &third)
    return (first, second, third)
}
