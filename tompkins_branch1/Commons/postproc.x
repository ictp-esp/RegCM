#csh                                              
set mydir=$PWD                                    
cd ../PostProc                                        
make
cd $mydir                                         
mv ../PostProc/postproc .                                
./postproc
