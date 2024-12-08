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

fn sphere(center: vec3<f32>, radius: f32, r: Ray) -> f32{
  var oc = center - r.origin;
  var a = dot(r.direction,r.direction);
  var b = dot(oc,r.direction);
  var c = dot(oc,oc) - radius*radius;
  var discriminant = b*b - a*c;
  if (discriminant < 0) {
    return -1.0;
  } else {
    return (b - sqrt(discriminant))/a;
  }
}

fn color(r: Ray) -> vec3<f32> {
  var t = sphere(vec3(0.0,0.0,-1.0), 0.5, r);
  if (t > 0.0) {
    var p = point_at_param(r,t);
    var N = (p-vec3(0.0,0.0,-1.0))/0.5;
    var light = vec3(-1.0,-1.0,0.0);
    return dot(light-p, N)*(vec3(1.0,0.0,0.0));
  }
  var rhat = normalize(r.direction);
  var a = 2*(rhat.y+0.5);
  //return (rhat.y*vec3(1.0,1.0,1.0)+(1.0-rhat.y)*vec3(0.2,0.5,1.0));
  return a*vec3(1.0,1.0,1.0)+(1.0-a)*vec3(0.5,0.7,1.0);
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
  var uv = 2*(vec2(pos.x/res.width, pos.y/res.height)-vec2(0.5,0.5)); 
  var ray: Ray;
  ray.origin = vec3(0.0,0.0,0.0);
  ray.direction = normalize(vec3((uv.x), aspect*(uv.y), -1.0)-ray.origin);
  return vec4(color(ray),1.0);
  //return vec4(uv.x, uv.y, 0.0, 0.0);
}

