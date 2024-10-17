use bytemuck::{Pod, Zeroable};
#[repr(C)]
#[derive(Clone, Copy, Pod, Zeroable)]
pub struct Vertex {
    _pos: [f32; 4],
}

fn vertex(pos: [i8; 3]) -> Vertex {
    Vertex {
        _pos: [pos[0] as f32, pos[1] as f32, pos[2] as f32, 1.0],
    }
}

pub fn create_vertices() -> (Vec<Vertex>, Vec<u16>) {
    let vertex_data = [
        vertex([-1, -1, 0]),
        vertex([1, -1, 0]),
        vertex([1, 1, 0]),
        vertex([-1, 1, 0]),
    ]
    .to_vec();
    let indices = [0, 1, 2, 0, 2, 3].to_vec();
    (vertex_data, indices)
}
