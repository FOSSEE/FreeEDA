// MNA based Circuit Simulator
// Yogesh Dilip Save
// Research Scholor
// IIT Bombay, Mumbai-400076

function I=myr_func(voltage,parameter)
    R=parameter(2);
	I=1/R*(voltage^3);
endfunction

function Gj=myr_Jacobian(voltage,parameter)
    R=parameter(2);
	Gj=3/R*(voltage^2);
endfunction

