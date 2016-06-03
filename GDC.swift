import Foundation

//MARK: GCD Extensions

typealias Queue = dispatch_queue_t

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

typealias OnceToken = dispatch_once_t

func once(token: UnsafeMutablePointer<OnceToken>, closure: () -> ()) {
	dispatch_once(token, closure)
}
