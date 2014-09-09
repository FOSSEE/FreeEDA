/****************************************************************************
	This routine assumes the existance of file named "vbs_files.txt" 
	and	the files decribed in the that file in current directory.
	File vbs_files.txt contains vbs values and corresponding Id-Vds_Vgs file names
	e.g. one entry may be 0.2 vbs_0.2.txt
*****************************************************************************/

/******************* Header *********************************/
#include <iostream>
#include <iomanip>
#include <fstream>
#include <math.h>
#include <cstdlib>
#include <string.h>


struct CoeffStruct{
	double x;
	double y;
	double z;
};

class NaturalCubicSpline1D{
public:
	double ValueAtX(double x);
	void initialize(int n,double* xData,double* yData);
	NaturalCubicSpline1D(int NO_OF_POINTS,double* xData,double* yData);		//Read from array
	NaturalCubicSpline1D();												//User input
	~NaturalCubicSpline1D();

private:
	void DetermineCoeff();
	int  NO_OF_POINTS;  
	CoeffStruct* coeffsArray;
};

class  yCSpair{
public:
	double y;
	NaturalCubicSpline1D xCubicSpline;
	yCSpair();
	~yCSpair();
};

class CubicCubic{
public:
	double evaluate(double x,double y);
	void Initialize(char* Id_Vd_Vg);
	const CubicCubic & operator=(const CubicCubic &rhs);
	CubicCubic(char* Id_Vd_Vg);
	CubicCubic(char* yfileName,char* xzfileName);
	CubicCubic(int no_yPoints, double yArray[],int *pxArray,double** xArray,double** zArray);
	CubicCubic();
	~CubicCubic();
private:
	int noYPoints;
	yCSpair *CubicSplines1D;
};

class IdVbs{
public:
	double Evaluate(double vds,double vgs,double vbs);
	void Initialize(double vbs);
	IdVbs();
	~IdVbs();
private:
	double vbs_l,vbs_h;   //vbs lies in interval [vbs_l,vbs_h]
	CubicCubic cc_l;
	CubicCubic cc_h;
}; 
/******************* Header *********************************/


/********************* SciLab Callable Routine *******************************/
//extern "C" _declspec(dllexport) 
extern "C"
void ids_c( double *vds,
            double *vgs,
            double *vbs,
            double *ids){
	IdVbs id;
	*ids=id.Evaluate(*vds,*vgs,*vbs);
}


/****************************************************/
using namespace std;

double NaturalCubicSpline1D::ValueAtX(double x){
	/*     x < Start Point first polynomial to be used
		   x > End   Point last  polynomial to be used
	*/
	
	// Find the segment where x lies
	int i=0;							// i is used outside loop
	for(i=0;i<NO_OF_POINTS-2;++i){		// upto NO_OF_POINTS-3
		if( x<=coeffsArray[i+1].x) {    // serially increment so valid
			break;
		}
	}
	//Evaluate the function
	double value=0,Bi=0,hi=1;
	hi = coeffsArray[i+1].x - coeffsArray[i].x;
	Bi = -hi*(coeffsArray[i+1].z + 2*coeffsArray[i].z)/6 + (coeffsArray[i+1].y - coeffsArray[i].y)/hi;  
	double xti=(x - coeffsArray[i].x);
	value = coeffsArray[i].y + xti*(Bi + xti*(coeffsArray[i].z/2 + xti*(coeffsArray[i+1].z - coeffsArray[i].z)/(6*hi)));
	return value;
}

void NaturalCubicSpline1D::DetermineCoeff(){
	double* u;
	u=new double[NO_OF_POINTS];
	double* v;
	v=new double[NO_OF_POINTS];

	u[0]=v[0]=0;   // not to be used
	double h1,h0,b1,b0;

	h0=coeffsArray[1].x - coeffsArray[0].x;
	h1=coeffsArray[2].x - coeffsArray[1].x;

	b0=(1/h0)*(coeffsArray[1].y - coeffsArray[0].y);
	b1=(1/h1)*(coeffsArray[2].y - coeffsArray[1].y);

	u[1]=2*( h0 + h1 );
	v[1]=6*( b1 - b0 );
	
	for(int i=2;i<NO_OF_POINTS;++i){
		h0=h1;
		b0=b1;
		h1=coeffsArray[i+1].x - coeffsArray[i].x;
		b1=(1/h1)*(coeffsArray[i+1].y - coeffsArray[i].y);
		u[i]=2*(h1+h0) - h0*h0/u[i-1];
		v[i]=6*(b1-b0) - h0*v[i-1]/u[i-1];
	}

	coeffsArray[0].z = coeffsArray[NO_OF_POINTS-1].z=0;  //Z(n-1) = Z(0) = 0 
	for(int i=NO_OF_POINTS-2;i>0;--i){
		h1=coeffsArray[i+1].x - coeffsArray[i].x;
		coeffsArray[i].z = (v[i] - h1*coeffsArray[i+1].z ) / u[i];
	}
}

void NaturalCubicSpline1D::initialize(int n,double* xData,double* yData){
	NO_OF_POINTS=n;
	coeffsArray=new CoeffStruct[NO_OF_POINTS];
	for(int i=0;i<NO_OF_POINTS;i++){
		coeffsArray[i].x=xData[i];
		coeffsArray[i].y=yData[i];
	}
	DetermineCoeff();
}

NaturalCubicSpline1D::NaturalCubicSpline1D(int n,double* xData,double* yData){
	NO_OF_POINTS=n;
	coeffsArray=new CoeffStruct[NO_OF_POINTS];
	for(int i=0;i<NO_OF_POINTS;i++){
		coeffsArray[i].x=xData[i];
		coeffsArray[i].y=yData[i];
	}
	DetermineCoeff();
}


NaturalCubicSpline1D::NaturalCubicSpline1D(){
}

NaturalCubicSpline1D::~NaturalCubicSpline1D(){
	delete [] coeffsArray;
	coeffsArray=0;
	
}



double CubicCubic::evaluate(double x,double y){
	double* yData=0;
	double* zData=0;
	yData=new double[noYPoints];		//actually y data for fixed x
	zData=new double[noYPoints];		//actually z data for fixed x
	for(int i=0;i<noYPoints;++i){
		yData[i]=CubicSplines1D[i].y;
		zData[i]=CubicSplines1D[i].xCubicSpline.ValueAtX(x);
	}
	NaturalCubicSpline1D  yzCubicSpline(noYPoints,yData,zData);  //y,z pair for fixed x=x
	return yzCubicSpline.ValueAtX(y);
}

void CubicCubic::Initialize(char* Id_Vd_Vg){
	ifstream idvdvg_file;
	int n_diffVgs,n_diffVds;
	idvdvg_file.open(Id_Vd_Vg);
	if(!idvdvg_file.is_open()){cout<<"Failed to open file named: "<<Id_Vd_Vg<<endl; exit(1);}
	
	idvdvg_file>>n_diffVgs;
	idvdvg_file>>n_diffVds;
	
	noYPoints=n_diffVgs;
	CubicSplines1D= new yCSpair[noYPoints];
	
	double* vds_array;
	double* ids_array;
	vds_array=new double[n_diffVds];
	ids_array=new double[n_diffVds];
	
	int index;
	double vds;
	double ids;
	double vgs;

	for(int i=0;i<n_diffVgs;++i){
		for(int j=0;j<n_diffVds;++j){
			if(idvdvg_file.eof()) {cout<<"End if file earlier than expected File Named: "<<Id_Vd_Vg<<endl; exit(1);}		
			idvdvg_file>>index;
			idvdvg_file>>vds;
			idvdvg_file>>ids;
			idvdvg_file>>vgs;
			CubicSplines1D[i].y=vgs; //repeat avoid
			vds_array[j]=vds;
			ids_array[j]=ids;
		}
		CubicSplines1D[i].xCubicSpline.initialize(n_diffVds,vds_array,ids_array);
	}
}
const CubicCubic & CubicCubic::operator=(const CubicCubic &rhs){
 if (this != &rhs) {  // make sure not same object
		
	 for(int i=0;i<noYPoints;++i){			 //free the old memory
		CubicSplines1D[i].~yCSpair();
	 }
		
		noYPoints=rhs.noYPoints;			// assign new values
		CubicSplines1D=rhs.CubicSplines1D;  // pointer assigned      
    }
    return *this;    // Return ref for multiple assignment
}

CubicCubic::CubicCubic(char* Id_Vd_Vg){
	ifstream idvdvg_file;
	int n_diffVgs,n_diffVds;
	idvdvg_file.open(Id_Vd_Vg);
	if(!idvdvg_file.is_open()){cout<<"Failed to open file named: "<<Id_Vd_Vg<<endl; exit(1);}
	
	idvdvg_file>>n_diffVgs;
	idvdvg_file>>n_diffVds;
	
	noYPoints=n_diffVgs;
	CubicSplines1D= new yCSpair[noYPoints];
	
	double* vds_array;
	double* ids_array;
	vds_array=new double[n_diffVds];
	ids_array=new double[n_diffVds];
		
	int index;
	double vds;
	double ids;
	double vgs;

	for(int i=0;i<n_diffVgs;++i){
		for(int j=0;j<n_diffVds;++j){
			if(idvdvg_file.eof()) {cout<<"End if file earlier than expected File Named: "<<Id_Vd_Vg<<endl; exit(1);}		
			idvdvg_file>>index;
			idvdvg_file>>vds;
			idvdvg_file>>ids;
			idvdvg_file>>vgs;
			CubicSplines1D[i].y=vgs;
			vds_array[j]=vds;
			ids_array[j]=ids;
		}
		CubicSplines1D[i].xCubicSpline.initialize(n_diffVds,vds_array,ids_array);
	}
}


CubicCubic::CubicCubic(int no_yPoints, double yArray[],int *pxArray,double* xArray[],double* zArray[]){
	noYPoints=no_yPoints;
	CubicSplines1D= new yCSpair[noYPoints];
	for(int i=0;i<noYPoints;++i){
		CubicSplines1D[i].y=yArray[i];
		CubicSplines1D[i].xCubicSpline.initialize(pxArray[i],xArray[i],zArray[i]);
	}
}

CubicCubic::CubicCubic(char* yfileName,char* xzfileName){
	ifstream yf,xzf;
	yf.open(yfileName);
	xzf.open(xzfileName);
	int n=1;
	xzf>>n;
	double* vds_array;
	double* ids_array;
	vds_array=new double[n];
	ids_array=new double[n];

	if(!yf.is_open() || !xzf.is_open()){cout<<"Failed to open file "<<yfileName<<endl; exit(3);}
	else{
		yf>>noYPoints;
		CubicSplines1D= new yCSpair[noYPoints];	
		for(int i=0;i<noYPoints;++i){
			yf>>CubicSplines1D[i].y;
			for(int j=0;j<n;++j){
				xzf>>vds_array[j];
				xzf>>ids_array[j];
			}
			
			CubicSplines1D[i].xCubicSpline.initialize(n,vds_array,ids_array);
		}
	}
}

CubicCubic::CubicCubic(){
}

CubicCubic::~CubicCubic(){
	delete [] CubicSplines1D;
	CubicSplines1D=0;
}

yCSpair::yCSpair(){
}

yCSpair::~yCSpair(){
}

double IdVbs::Evaluate(double vds,double vgs,double vbs){
	if(vbs_l<=vbs && vbs<vbs_h) {
	}
	else{
		Initialize(vbs);
	}
	double y1,y2,value;
	y1=cc_l.evaluate(vds,vgs);
	y2=cc_h.evaluate(vds,vgs);
	value=y1+(vbs-vbs_l)*(y2-y1)/(vbs_h-vbs_l);
	return value;
}


void IdVbs::Initialize(double vbs){
	double vbs_lp,vbs_hp;
	char filename_l[40];
	char filename_h[40];
	
	ifstream vbsf;
	vbsf.open("vbs_files.txt");  //Fixed name this file must exsit
	if(!vbsf.is_open()) {
		cout<<"Failed to open vbs_files.txt \nIts a compulsory file to be there in current directory"<<endl; exit(3);
	}
	
	vbsf>>vbs_lp;
	vbsf>>filename_l;

	bool found=false;

	while(!found || !vbsf.eof()){
		vbsf>>vbs_hp;
		vbsf>>filename_h;
	
		if(vbs>=vbs_lp && vbs<vbs_hp){
			found=true;
			break;
		}
		vbs_lp=vbs_hp;
		strcpy(filename_l,filename_h);
	}
	
	if(!found){ cout<<"Vgs out of range, This routine does not do Extrapolation"<<endl; exit(1);}
	
	if( fabs(vbs_l-vbs_hp)<1e-7 ){		// vgs hag gone just one step lower so
		cc_h=cc_l;						// use old value why compute again
		cc_l.Initialize(filename_l);	
	}
	else if( fabs(vbs_lp-vbs_h)<1e-7 ){	// vgs hag gone just one step higher so
		cc_l=cc_h;						// use old value why compute again
		cc_h.Initialize(filename_h);
	}
	else{
		cc_l.Initialize(filename_l);  
		cc_h.Initialize(filename_h);
	}
	
	vbs_l=vbs_lp;
	vbs_h=vbs_hp;
}

IdVbs::IdVbs(){
	vbs_l=213.0;   //some value not to occur actually
	vbs_h=-213.0;
}

IdVbs::~IdVbs(){
};
/********************** End ******************************/
