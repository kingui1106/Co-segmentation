delete('./vlf2/vlfeat-0.9.21/toolbox/mex/');
mkdir('./vlf2/vlfeat-0.9.21/toolbox/mex/');
run('./vlf2\vlfeat-0.9.21\toolbox\vl_compile')
run('./vlf2\vlfeat-0.9.21\toolbox\vl_setup')

delete('./grabcut/Grabcut/*.mex*')
cd ./grabcut/Grabcut/
compile_gc
cd ..
cd ..
delete('./RBD/Funcs/SlIC/*.mex*');
run('./RBD/compile_RBD.m');
% Pls comment line 5 of project.h in mexDenseSIFT and SiftFlow folders if you are compiling using visual studio in windows, and uncomment if you are in linux or mac os.
try
delete('./SiftFlow/*.mex*')
cd ./SiftFlow/
mex mexDiscreteFlow.cpp BPFlow.cpp Stochastic.cpp
cd ..

delete('./mexDenseSIFT/*.mex*')
cd ./mexDenseSIFT/
mex mexDenseSIFT.cpp Matrix.cpp Vector.cpp
cd ..
msgbox('Successfully Compiled');
catch
msgbox('Pls comment line 5 of project.h in mexDenseSIFT and SiftFlow folders if you are compiling using visual studio in windows, and uncomment if you are in linux or mac os.');   
end