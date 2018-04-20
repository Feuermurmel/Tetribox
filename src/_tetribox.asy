access _settings as settings;
import _util;


path offset_path(path p, real o) {
	import geometry;
	
	line move(line l) {
		return l - l.v * o;
	}
	
	path res;
	
	for (int i : range(0, size(p))) {
		pair a = point(p, i - 1);
		pair b = point(p, i);
		pair c = point(p, i + 1);
		
		path new_points;
		
		if (a == b) {
			if (b != c) {
				new_points = move(line(b, c)).A;
			}
		} else {
			if (b == c) {
				new_points = move(line(a, b)).B;
			} else {
				line l1 = line(a, b);
				line l2 = line(b, c);
				
				pair new_point = intersectionpoint(move(l1), move(l2));
				
				if (abs(b - new_point) < 1000mm) {
					new_points = new_point;
				}
			}
		}
		
		res = res -- new_points;
	}
	
	if (cyclic(p)) {
		res = res -- cycle;
	}
	
	return res;
}


path fix_corners(path p) {
	import geometry;
	
	path res;
	
	for (int i : range(0, size(p))) {
		pair a = point(p, i - 1);
		pair b = point(p, i);
		pair c = point(p, i + 1);
		real min_dist = min(abs(b - a), abs(c - b));
		
		path new_points;
		
		if (a == b) {
			if (b != c) {
				new_points = b;
			}
		} else {
			if (b == c) {
				new_points = b;
			} else {
				line l1 = line(a, b);
				line l2 = line(b, c);
				real angle = modulo(angle(l2.u) - angle(l1.u), 2 * pi);
				
				if (angle < pi) {
					real r = min(min_dist / 2, settings.convex_corner_radius);
					
					new_points = l1.B - l1.u * r {l1.u} .. {l2.u} l2.A + l2.u * r;
				} else {
					real r = settings.concave_corner_radius;
					
					if (min_dist < 2 * r) {
						new_points = b;
					} else {
						new_points = (l1.B - l1.u * r) .. controls (l1.B + l1.u * r) and (l2.A - l2.u * r) .. (l2.A + l2.u * r);
					}
				}
			}
		}
		
		res = res -- new_points;
	}
	
	if (cyclic(p)) {
		res = res -- cycle;
	}
	
	return res;
}


path linearize_path(path p) {
	path res;
	
	for (int i : range(0, size(p))) {
		if (!straight(p, i)) {
			int steps = 20;
			
			for (int j : range(1, steps)) {
				res = res -- point(p, i + j / steps);
			}
		}
		
		res = res -- point(p, i + 1);
	}
	
	if (cyclic(p)) {
		res = res -- cycle;
	}
	
	return res;
}


struct Piece {
	path p;
	
	void operator init() {
	}
	
	pair position(pair grid = (0, 0), real height = 0, pair wood = (0, 0), pair hstud = (0, 0), real vstud = 0, real slot_gap = 0, pair overlap = (0, 0), pair offset = (0, 0)) {
		return grid * settings.grid_size + (0, height) * settings.height + wood * settings.wood_thickness + hstud * settings.horizontal_studs_size + (0, vstud) * settings.vertical_studs_size + (slot_gap, 0) * settings.slot_gap + overlap * settings.tenon_overlap + offset;
	}
	
	void add(pair grid = (0, 0), real height = 0, pair wood = (0, 0), pair hstud = (0, 0), real vstud = 0, real slot_gap = 0, pair offset = (0, 0)) {
		this.p = this.p -- this.position(grid, height, wood, hstud, vstud, slot_gap, offset);
	}
	
	void output() {
		path p = this.p;
		
		if (!cyclic(p)) {
			p = p -- cycle;
		}
		
		p = fix_corners(offset_path(linearize_path(p), settings.laser_offset));
		
		draw(p, settings.cut_pen);
	}
}


struct TenonPosition {
	// Position along the edge where the tenons are placed, in units of the grid length (or the height of a side in case of tenons at a vertical edge.)
	real u;
	// Position perpendicular to the edge, from 0 to 1.
	real v;
	// Direction along the edge on which the tenons are placed which is "outside" of the final shape.
	real o;
	
	void operator init(real u, real v, real o) {
		this.u = u;
		this.v = v;
		this.o = o;
	}
}


TenonPosition[] reverse(TenonPosition[] a) {
	TenonPosition[] res;
	
	for (TenonPosition i : a) {
		res.insert(0, i);	
	}
	
	return res;
}



TenonPosition[] horizontal_tenons(int size, bool reverse = false) {
	TenonPosition[] res;
	
	for (int i : range(0, size)) {
		for (int j : range(0, settings.horizontal_fingers_per_grid)) {
			for (int k : range(0, 2)) {
				real o;
				
				if (i + j == 0) {
					o = 0;
				} else {
					o = j % 2 * 2 - 1;
				}
				
				res.push(
					TenonPosition(
						i + j / settings.horizontal_fingers_per_grid,
						(j + k + 1) % 2,
						o));
			}
		}
	}
	
	if (reverse) {
		return reverse(res);
	} else {
		return res;
	}
}


TenonPosition[] vertical_tenons(bool reverse = false) {
	TenonPosition[] res;
	
	for (int i : range(1, settings.vertical_fingers + 1)) {
		for (int j : range(0, 2)) {
			real o;
			
			if (i == settings.vertical_fingers && j == 0) {
				o = 0;
			} else {
				o = (i + 1) % 2 * 2 - 1;
			}
			
			res.push(
				TenonPosition(
					i / settings.vertical_fingers,
					(i + j + 1) % 2,
					o));
		}
	}
	
	res.delete(res.length - 1);
	
	if (reverse) {
		return reverse(res);
	} else {
		return res;
	}
}
