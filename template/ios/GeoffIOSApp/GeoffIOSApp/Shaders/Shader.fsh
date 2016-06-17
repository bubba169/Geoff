//
//  Shader.fsh
//  GeoffIOSApp
//
//  Created by Simon Morris on 17/06/2016.
//  Copyright © 2016 MoJaWorks. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
