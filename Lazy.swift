class Lazy<T> {

	private var valueInitializer: () -> T
		private var _value: T?
		var value: T {
			get {
				if self._value == nil {
					self._value = self.valueInitializer()
				}

				return self._value!
			}
			set {
				self._value = newValue
			}
		}

	var isEmpty: Bool {
		return self._value == nil
	}

	init(initializer: (() -> T)) {
		self.valueInitializer = initializer
	}

	func reset() {
		self._value = nil
	}
}
