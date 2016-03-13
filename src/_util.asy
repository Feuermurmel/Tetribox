
int[] range(int start, int end, int step=1) {
	int[] res;
	
	for (int i = start; i < end; i += step) {
		res.push(i);
	}
	
	return res;
}


int[] reverse(int[] a) {
	int[] res;
	
	for (int i : a) {
		res.insert(0, i);	
	}
	
	return res;
}

real modulo(real x, real m) {
	return x - floor(x / m) * m;
}
