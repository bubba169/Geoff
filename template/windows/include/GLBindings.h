#include "glfw/glfw3.h"

namespace geoff {
	
	class GLBindings
	{
		public:
			static void clear( int mask );
			static void clearColor( float r, float g, float b, float a );
			
			int hello();
	};
	
};



