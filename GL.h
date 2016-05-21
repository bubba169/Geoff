#include "glfw3.h"

namespace geoff {
	namespace utils {
		
		class GL
		{
			public:
				static void clear( int mask );
				static void clearcolor( float r, float g, float b, float a );
		};
	};
};