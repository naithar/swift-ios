struct Weak<T> {
	private weak var _value : AnyObject?

		var value: T? {
			return self._value as? T
		}

	init (value: T) {
		self._value = value as? AnyObject
	}
}
