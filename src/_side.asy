access _tetribox as tetribox;
import _util;


void side(int size, int stud_phase) {
	tetribox.Piece p = tetribox.Piece();
	
	p.add(grid = (0, 0), height = 0, wood = (0, -1), hstud = (0, 0), vstud = 0, slot_gap = 0);
	
	for (tetribox.TenonPosition j : tetribox.horizontal_tenons(size)[2:]) {
		p.add(grid = (j.u, 0), height = 0, wood = (0, j.v - 1), hstud = (0, 0), vstud = 0, slot_gap = 0);
	}
	
	p.add(grid = (size, 0), height = 0, wood = (0, 0), hstud = (0, 0), vstud = 0, slot_gap = 0);
	
	for (tetribox.TenonPosition i : tetribox.vertical_tenons()) {
		p.add(grid = (size, 0), height = i.u, wood = (i.v, 0), hstud = (0, 0), vstud = 0, slot_gap = 0);
	}
	
	for (int i : reverse(range(1, size))) {
		int vstud = (i + stud_phase) % 2 - 2;
		
		p.add(grid = (i, 0), height = 1, wood = (1, 0), hstud = (0, 0), vstud = 0, slot_gap = 1);
		p.add(grid = (i, 0), height = 1, wood = (1, 0), hstud = (0, 0), vstud = vstud, slot_gap = 1);
		p.add(grid = (i, 0), height = 1, wood = (0, 0), hstud = (0, 0), vstud = vstud, slot_gap = -1);
		p.add(grid = (i, 0), height = 1, wood = (0, 0), hstud = (0, 0), vstud = 0, slot_gap = -1);
	}
	
	for (tetribox.TenonPosition i : tetribox.vertical_tenons(true)) {
		p.add(grid = (0, 0), height = i.u, wood = (i.v, 0), hstud = (0, 0), vstud = 0, slot_gap = 0);
	}
	
	p.output();
}
