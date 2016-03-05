access _tetribox as tetribox;
import _util;


void divider(int size) {
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
	
	for (int i : reverse(range(1, size))) {
		p.add(grid = (i, 0), height = 1, wood = (1, 0), hstud = (0, 0), vstud = 0, slot_gap = 1);
		p.add(grid = (i, 0), height = 1, wood = (1, 0), hstud = (0, 0), vstud = -2, slot_gap = 1);
		p.add(grid = (i, 0), height = 1, wood = (0, 0), hstud = (0, 0), vstud = -2, slot_gap = -1);
		p.add(grid = (i, 0), height = 1, wood = (0, 0), hstud = (0, 0), vstud = 0, slot_gap = -1);
	}
	
	p.add(grid = (0, 0), height = 1, wood = (0, 0), hstud = (0, 0), vstud = 0, slot_gap = 0);
	
	p.add(grid = (0, 0), height = 1, wood = (0, 0), hstud = (0, 0), vstud = -1, slot_gap = 0);
	p.add(grid = (0, 0), height = 1, wood = (1, 0), hstud = (0, 0), vstud = -1, slot_gap = 0);
	p.add(grid = (0, 0), height = 0, wood = (1, 0), hstud = (0, 0), vstud = 0, slot_gap = 0);
	
	p.output();
}
