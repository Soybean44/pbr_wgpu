struct Resolution {
  width: f32,
  height: f32,
};

struct Ray {
  origin: vec3<f32>,
  direction: vec3<f32>,
};

fn point_at_param(r: Ray, t: f32) -> vec3<f32> {
  return r.origin + t*r.direction;
}

fn sphere(center: vec3<f32>, radius: f32, r: Ray) -> bool{
  var oc = r.origin - center;
  var a = dot(r.direction, r.direction);
  var b = 2.0 * dot(oc, r.direction);
  var c = dot(oc, oc) - radius*radius;
  var discriminant = b*b - 4*a*c;
  return (discriminant > 0);
}

fn color(r: Ray) -> vec3<f32> {
  if (sphere(vec3(0.0,0.0,1.0), 0.5, r)) {
    return vec3(1.0,0.0,0.0);
  }
  var rhat = normalize(r.direction);
  var t = rhat.y;
  return (t*vec3(1.0,1.0,1.0)+(1.0-t)*vec3(0.2,0.5,1.0));
}


@group(0) @binding(0)
var<uniform> res: Resolution;

@vertex
fn vs_main(@location(0) pos: vec4<f32>) -> @builtin(position) vec4<f32> {
    return pos;
}

@fragment
fn fs_main(@builtin(position) pos: vec4<f32>) -> @location(0) vec4<f32> {
  var aspect = res.height/res.width;
  var uv = pos.xy/vec2(res.width,res.height); 
  var ray: Ray;
  ray.origin = vec3(0.0,0.0,0.0);
  ray.direction = vec3((2*uv.x-1.0), aspect*(2*uv.y-1.0), 1.0);
  return vec4(color(ray),1.0);
}

