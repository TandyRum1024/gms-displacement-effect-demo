// It might be a simple passthrough vertex shader
// but actually it is simple passthrough vertex shader.
// Hi, Vsauce, Michael here. Today we're going to talk about the definition of the word simple.
// (cues vsauce music)
attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~/*
    IT'S GHERKIN TIME BOYYYY
    https://dn.ht/picklecat/
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D uDepthmap;
uniform vec2 uDirection;
uniform float uIntensity;
uniform float uTint;
uniform vec4 uTintColour;

void main()
{
    vec4 final = vec4(0.0);
    
    // sample from displacement map and
    // remap it from [0..1] to [-1, 1] and scale it as needed
    float depth = (texture2D(uDepthmap, v_vTexcoord).r) * 2.0 - 1.0;
    depth *= 0.01;
    
    // sample from original texture with offset from displacement
    vec2 offuv = v_vTexcoord + (uDirection * uIntensity * depth);
    final = v_vColour * texture2D(gm_BaseTexture, offuv);
    
    // tint the whole result to given colour
    // (used for drop-shadow effect)
    final = mix(final, vec4(uTintColour.rgb, uTintColour.a * final.a), uTint);
    
    gl_FragColor = final;
}

