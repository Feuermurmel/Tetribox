access _settings as settings;
access _tetribox as tetribox;
import _util;


void base(int sizex, int sizey) {
	tetribox.Piece p = tetribox.Piece();
	
	for (tetribox.TenonPosition j : tetribox.horizontal_tenons(sizex)) {
		p.add(grid = (j.u, 0), height = 0, wood = (1, j.v), hstud = (0, 0), vstud = 0, slot_gap = 0);
	}
	
	for (tetribox.TenonPosition j : tetribox.horizontal_tenons(sizey)) {
		p.add(grid = (sizex, j.u), height = 0, wood = (1 - j.v, 1), hstud = (0, 0), vstud = 0, slot_gap = 0);
	}
	
	for (tetribox.TenonPosition j : tetribox.horizontal_tenons(sizex)) {
		p.add(grid = (sizex - j.u, sizey), height = 0, wood = (0, 1 - j.v), hstud = (0, 0), vstud = 0, slot_gap = 0);
	}
	
	for (tetribox.TenonPosition j : tetribox.horizontal_tenons(sizey)) {
		p.add(grid = (0, sizey - j.u), height = 0, wood = (j.v, 0), hstud = (0, 0), vstud = 0, slot_gap = 0);
	}
	
	p.output();
	
	for (int iy : range(1, sizey)) {
		for (int ix : range(1, sizex)) {
			tetribox.Piece p = tetribox.Piece();
			
			p.add(grid = (ix, iy), height = 0, wood = (.5, 0), hstud = (-.5, 0), vstud = 0, slot_gap = 0);
			p.add(grid = (ix, iy), height = 0, wood = (.5, 1), hstud = (-.5, 0), vstud = 0, slot_gap = 0);
			p.add(grid = (ix, iy), height = 0, wood = (0, 1), hstud = (0, 0), vstud = 0, slot_gap = 0);
			p.add(grid = (ix, iy), height = 0, wood = (0, .5), hstud = (0, .5), vstud = 0, slot_gap = 0);
			p.add(grid = (ix, iy), height = 0, wood = (1, .5), hstud = (0, .5), vstud = 0, slot_gap = 0);
			p.add(grid = (ix, iy), height = 0, wood = (1, 1), hstud = (0, 0), vstud = 0, slot_gap = 0);
			p.add(grid = (ix, iy), height = 0, wood = (.5, 1), hstud = (.5, 0), vstud = 0, slot_gap = 0);
			p.add(grid = (ix, iy), height = 0, wood = (.5, 0), hstud = (.5, 0), vstud = 0, slot_gap = 0);
			p.add(grid = (ix, iy), height = 0, wood = (1, 0), hstud = (0, 0), vstud = 0, slot_gap = 0);
			p.add(grid = (ix, iy), height = 0, wood = (1, .5), hstud = (0, -.5), vstud = 0, slot_gap = 0);
			p.add(grid = (ix, iy), height = 0, wood = (0, .5), hstud = (0, -.5), vstud = 0, slot_gap = 0);
			p.add(grid = (ix, iy), height = 0, wood = (0, 0), hstud = (0, 0), vstud = 0, slot_gap = 0);
			
			p.p = tetribox.offset_path(p.p -- cycle, -settings.slot_gap);
			
			p.output();
		}
	}
}
