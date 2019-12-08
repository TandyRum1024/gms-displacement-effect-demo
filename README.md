# Displacement / Per-pixel parallax shader effect demonstration project for Gamemaker : Studio 1
![preview](pic/PREVIEW.gif)
![if you see this I love yuo](pic/PREVIEW2.gif)

This was an old demo project I made for fun all the way back in march.<br>
Heavily influenced from the post by [Alan zucconi's post on parallax shader](https://www.alanzucconi.com/2019/01/01/parallax-shader/).<br>
This repo comes with a pre-compiled executable binary build that you can fire up & test it...<br>
You can press any key on the keyboard to re-roll the visuals.

# Fragment shader for displacement effect
```
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
```

# Assets used
Following assets used in this project is not work of mine :<br>
Cat's texture & depth information : [Dennis hotson's Pickle cat demo](https://dn.ht/picklecat/)<br>
Another cat texture : [AnyaBoz's still footage of Persian Cat Room Guardian](https://www.deviantart.com/anyaboz/art/Persian-Cat-Room-Guardian-390914412) (manually cropped & edited for this project)<br>
"""Meat""" texture : [Kevin Yagher's MSN commercial earthworm character](https://www.instagram.com/p/BfjdZWen4ip/)