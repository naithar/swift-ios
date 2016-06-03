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


import Foundation

typealias Queue = dispatch_queue_t
typealias OnceToken = dispatch_once_t

enum QueueType {
    
    case Main
    case Low, Normal, High, Background
    case Concurrent(name: String)
    case Serial(name: String)
    
    var priority: dispatch_queue_priority_t {
        let priority: dispatch_queue_priority_t
        
        switch self {
        case .Low:
            priority = DISPATCH_QUEUE_PRIORITY_LOW
        case .High:
            priority = DISPATCH_QUEUE_PRIORITY_HIGH
        case .Background:
            priority = DISPATCH_QUEUE_PRIORITY_BACKGROUND
        default:
            priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        }
        
        return priority
    }
}

func queue(type: QueueType) -> Queue {
    let queue: Queue
    
    switch type {
    case .Main:
        queue = dispatch_get_main_queue()
    case .Low, .Normal, .High, .Background:
        queue = dispatch_get_global_queue(type.priority, 0)
    case .Concurrent(let name):
        queue = dispatch_queue_create(name, DISPATCH_QUEUE_CONCURRENT)
    case .Serial(let name):
        queue = dispatch_queue_create(name, DISPATCH_QUEUE_SERIAL)
    }
    
    return queue
}

func delay(delay: Double,
           queue: Queue = dispatch_get_main_queue(),
           closure: () -> ()) {
    let dispatchDelta = Int64(delay * Double(NSEC_PER_SEC))
    let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, dispatchDelta)
    dispatch_after(dispatchTime, queue, closure)
}

func async(queue queue: Queue = dispatch_get_main_queue(),
                 closure: () -> ()) {
    dispatch_async(queue, closure)
}

func once(token: UnsafeMutablePointer<OnceToken>, closure: () -> ()) {
    dispatch_once(token, closure)
}
