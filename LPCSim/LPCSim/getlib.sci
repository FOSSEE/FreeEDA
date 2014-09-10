// MNA based Circuit Simulator
// Yogesh Dilip Save
// Research Scholor
// IIT Bombay, Mumbai-400076

function I=func(voltage,parameter)
	exec('myr.sci',-1);
	I=myr_func(voltage,parameter);
endfunction

function Gj=jacobian(voltage,parameter)
	exec('myr.sci',-1);
	Gj=myr_Jacobian(voltage,parameter);
endfunction
