attribute vec2 aVertexPosition;

uniform mat3 projectionMatrix;
uniform mat3 filterMatrix;

varying vec2 vTextureCoord;
varying vec2 vFilterCoord;
varying vec4 vFilterClamp;

uniform vec4 destinationFrame;
uniform vec4 sourceFrame;

vec4 filterVertexPosition( void )
{
    vec2 position = aVertexPosition * max(sourceFrame.zw, vec2(0.)) + sourceFrame.xy;

    return vec4((projectionMatrix * vec3(position, 1.0)).xy, 0.0, 1.0);
}

vec2 filterTextureCoord( void )
{
    return aVertexPosition * (sourceFrame.zw / destinationFrame.zw);
}

void main(void)
{
	gl_Position = filterVertexPosition();
	vTextureCoord = filterTextureCoord();
	vFilterCoord = ( filterMatrix * vec3( vTextureCoord, 1.0)  ).xy;

	vFilterClamp.zw = (sourceFrame.zw - 1.) / destinationFrame.zw;
}