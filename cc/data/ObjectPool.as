package cc.data {
	
	import flash.utils.Dictionary;
	
	public class ObjectPool {
		
		private var _objectPool:Dictionary;
		
		public function ObjectPool() {
			
			_objectPool = new Dictionary();
			
		}
		
		public function seedPool(type:Object, object:IPoolable):void {
			
			if (!_objectPool[type]) {
				_objectPool[type] = new Vector.<IPoolable>();
			}
			_objectPool[type].push(object);
			object.returnedToPool();
			
		}
		
		public function getPooled(type:Object):IPoolable {
			
			if (_objectPool[type]) {
				
				//find the next pooled object and return it
				for (var i:int = 0; i < _objectPool[type].length; ++i) {
					if (_objectPool[type][i].isPooled) {
						_objectPool[type][i].removedFromPool();
						return _objectPool[type][i];
					}
				}
				
				//no object was found so insert a new object in the pool and return it
				var object:IPoolable = _objectPool[type][0].clone();
				_objectPool[type].push(object);
				object.removedFromPool();
				return object;
				
			} else {
				throw new PoolError("Type must be seeded before calling getPooled()");
			}
			
		}
		
		public function returnToPool(object:IPoolable):void {
			object.returnedToPool();
		}
		
	}
	
}

class PoolError extends Error {
	public function PoolError(message:String) {
		super(message);
	}
}