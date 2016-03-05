
int[] range(int start, int end) {
	int[] res;
	
	for (int i = start; i < end; i += 1) {
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
