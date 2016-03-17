access _tetribox as tetribox;
import _util;


void holder(int size, int parity) {
	tetribox.Piece p = tetribox.Piece();
	
	for (int i : range(1, size)) {
		p.add(grid = (i, 0), height = 0, wood = (.5, 0), hstud = (-.5, 0), vstud = 0, slot_gap = 0);
		p.add(grid = (i, 0), height = 0, wood = (.5, -1), hstud = (-.5, 0), vstud = 0, slot_gap = 0);
		p.add(grid = (i, 0), height = 0, wood = (.5, -1), hstud = (.5, 0), vstud = 0, slot_gap = 0);
		p.add(grid = (i, 0), height = 0, wood = (.5, 0), hstud = (.5, 0), vstud = 0, slot_gap = 0);
	}
	
	p.add(grid = (size, 0), height = 0, wood = (0, 0), hstud = (0, 0), vstud = 0, slot_gap = 0);
	p.add(grid = (size, 0), height = 1, wood = (0, 0), hstud = (0, 0), vstud = -2, slot_gap = 0);
	p.add(grid = (size, 0), height = 1, wood = (1, 0), hstud = (0, 0), vstud = -2, slot_gap = 0);
	p.add(grid = (size, 0), height = 1, wood = (1, 0), hstud = (0, 0), vstud = -1, slot_gap = 0);
	p.add(grid = (size, 0), height = 1, wood = (0, 0), hstud = (0, 0), vstud = -1, slot_gap = 0);
	p.add(grid = (size, 0), height = 1, wood = (0, 0), hstud = (0, 0), vstud = 0, slot_gap = 0);
	
	real phi = asin(tetribox.settings.d / tetribox.settings.r);
	
	for (int i : reverse(range(1, size))) {
		if (i % 2 == parity) {
			// Holder slot
			pair x = (i,0) * tetribox.settings.grid_size + (0, 1) * tetribox.settings.height;
			pair xl = x - tetribox.settings.d * (1,0);
			pair xr = x + tetribox.settings.d * (1,0);
			pair xc = (i,0) * tetribox.settings.grid_size + (0, 0.5) * tetribox.settings.height;
			pair xs = xr - (0, tetribox.settings.t - tetribox.settings.r*cos(phi));
			pair xe = xl - (0, tetribox.settings.t - tetribox.settings.r*cos(phi));
			
			path q = xr -- xs -- arc(xc, tetribox.settings.r, degrees(pi/2-phi), degrees(pi/2 + phi), false) -- xe -- xl;
			p.add_subpath(q);
		} else {
			// Normal slot
			p.add(grid = (i, 0), height = 1, wood = (1, 0), hstud = (0, 0), vstud = 0, slot_gap = 1);
			p.add(grid = (i, 0), height = 1, wood = (1, 0), hstud = (0, 0), vstud = -2, slot_gap = 1);
			p.add(grid = (i, 0), height = 1, wood = (0, 0), hstud = (0, 0), vstud = -2, slot_gap = -1);
			p.add(grid = (i, 0), height = 1, wood = (0, 0), hstud = (0, 0), vstud = 0, slot_gap = -1);
		}
	}
	
	p.add(grid = (0, 0), height = 1, wood = (0, 0), hstud = (0, 0), vstud = 0, slot_gap = 0);
	
	p.add(grid = (0, 0), height = 1, wood = (0, 0), hstud = (0, 0), vstud = -1, slot_gap = 0);
	p.add(grid = (0, 0), height = 1, wood = (1, 0), hstud = (0, 0), vstud = -1, slot_gap = 0);
	p.add(grid = (0, 0), height = 0, wood = (1, 0), hstud = (0, 0), vstud = 0, slot_gap = 0);
	
	p.output();
}
