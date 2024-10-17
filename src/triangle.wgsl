struct Resolution {
  width: f32,
  height: f32,
};

@group(0) @binding(0)
var<uniform> res: Resolution;

@vertex
fn vs_main(@location(0) pos: vec4<f32>) -> @builtin(position) vec4<f32> {
    return pos;
}

@fragment
fn fs_main(@builtin(position) pos: vec4<f32>) -> @location(0) vec4<f32> {
  var uv = pos.xy/vec2(res.width,res.height);
  return vec4(uv.x,uv.y,0.0,1.0);
}

