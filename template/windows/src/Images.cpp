#include <Images.h>

namespace geoff
{
	
	Images::getImageBytes( ::String* filepath, void* byteArray, int& size )
	{
		unsigned int imageName;
		ilGenImages( 1, &imageName );
		ilBindImage( imageName );
		
		ilLoadImage( filepath->__CStr() );
		//ilSave
		
		
		
	}
	
}