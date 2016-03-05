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
	return p;
}


struct Piece {
	path p;
	
	void operator init() {
	}
	
	void add(pair grid = (0, 0), real height = 0, pair wood = (0, 0), pair hstud = (0, 0), real vstud = 0, real slot_gap = 0) {
		this.p = this.p -- grid * settings.grid_size + (0, height) * settings.height + wood * settings.wood_thickness + hstud * settings.horizontal_studs_size + (0, vstud) * settings.vertical_studs_size + (slot_gap, 0) * settings.slot_gap;
	}
	
	void output() {
		draw(fix_corners(offset_path(this.p -- cycle, settings.laser_offset)), settings.cut_pen);
	}
}


struct TenonPosition {
	real u;
	real v;
	
	void operator init(real u, real v) {
		this.u = u;
		this.v = v;
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
			int parity = j % 2;
			
			for (int k : range(0, 2)) {
				res.push(TenonPosition(i + j / settings.horizontal_fingers_per_grid, (j + k + 1) % 2));
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
		int parity = i % 2;
		
		for (int j : range(0, 2)) {
			res.push(TenonPosition(i / settings.vertical_fingers, (i + j + 1) % 2));
		}
	}
	
	res.delete(res.length - 1);
	
	if (reverse) {
		return reverse(res);
	} else {
		return res;
	}
}
