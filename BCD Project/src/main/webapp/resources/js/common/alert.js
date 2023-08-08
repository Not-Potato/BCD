function alertFunction(msg, status) {
	Swal.fire({
		icon: status, 
		title: status, 
		text: msg
	});
}