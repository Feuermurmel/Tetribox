access _tetribox as tetribox;
access _settings as settings;
import _util;


void side(int size, int stud_phase, bool holes) {
	tetribox.Piece p = tetribox.Piece();
	
	p.add(grid = (0, 0), height = 0, wood = (0, -1), hstud = (0, 0), vstud = 0, slot_gap = 0);
	
	for (tetribox.TenonPosition j : tetribox.horizontal_tenons(size)[2:]) {
		p.add(grid = (j.u, 0), height = 0, wood = (0, j.v - 1), hstud = (0, 0), vstud = 0, slot_gap = 0, offset = j.o * E);
	}
	
	p.add(grid = (size, 0), height = 0, wood = (0, 0), hstud = (0, 0), vstud = 0, slot_gap = 0);
	
	for (tetribox.TenonPosition i : tetribox.vertical_tenons()) {
		p.add(grid = (size, 0), height = i.u, wood = (i.v, 0), hstud = (0, 0), vstud = 0, slot_gap = 0, offset = i.o * N);
	}
	
	for (int i : reverse(range(1, size))) {
		int vstud = (i + stud_phase) % 2 - 2;
		
		p.add(grid = (i, 0), height = 1, wood = (1, 0), hstud = (0, 0), vstud = 0, slot_gap = 1);
		p.add(grid = (i, 0), height = 1, wood = (1, 0), hstud = (0, 0), vstud = vstud, slot_gap = 1);
		p.add(grid = (i, 0), height = 1, wood = (0, 0), hstud = (0, 0), vstud = vstud, slot_gap = -1);
		p.add(grid = (i, 0), height = 1, wood = (0, 0), hstud = (0, 0), vstud = 0, slot_gap = -1);
	}
	
	for (tetribox.TenonPosition i : tetribox.vertical_tenons(true)) {
		p.add(grid = (0, 0), height = i.u, wood = (i.v, 0), hstud = (0, 0), vstud = 0, slot_gap = 0, offset = i.o * S);
	}
	
	p.output();
	
	if (holes) {
		for (int i = floor((size - 2) / 2); i < floor((size + 3) / 2); i += 1) {
			tetribox.Piece p = tetribox.Piece();
			
			real r = settings.hole_radius;
			real oh = settings.hole_slot_offset;
			real ov = settings.hole_top_offset;
			
			p.p = p.p .. p.position(grid = (i, 0),     height = 1, wood = 1, offset = (oh + r, -ov))          {right};
			p.p = p.p .. p.position(grid = (i + 1, 0), height = 1, wood = 0, offset = (-oh - r, -ov))         {right};
			p.p = p.p .. p.position(grid = (i + 1, 0), height = 1, wood = 0, offset = (-oh, -ov - r))         {down};
			p.p = p.p .. p.position(grid = (i + 1, 0), height = 1, wood = 0, offset = (-oh - r, -ov - 2 * r)) {left};
			p.p = p.p .. p.position(grid = (i, 0),     height = 1, wood = 1, offset = (oh + r,  -ov - 2 * r)) {left};
			p.p = p.p .. p.position(grid = (i, 0),     height = 1, wood = 1, offset = (oh, -ov - r))          {up};
			p.p = p.p .. cycle;
			
			p.output();
		}
	}
}
