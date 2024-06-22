% To read and decode EISCAT hdf5 file format...
% load_param_hdf5.m and pp_merge.m are from the GUISDAP9 package.
% Schedule and Madrigal data files are all in hdf5
%
%
% Select filename:
hdf5file='EISCAT_2004-12-01.hdf5'; 

% Read the data from the HDF5 file:
[Time,par2D,par1D,rpar2D,err2D,errs2d]=load_param_hdf5(hdf5file);

% Time = 2xtime vector for start/end times of the data dump
%
% Default (load_param_hdf5(hdf5file)) sets
%   pars1d  = {'az' 'el' 'Pt' 'Tsys'};
%   par2d_id  = {'range' 'h' 'Ne' 'Tr' 'Ti' 'Vi' 'Collf' 'po+' 'res'};
%   do_rpars = true
%   errs2d_id  = {'var_Ne' 'var_Tr' 'var_Ti' 'var_Vi' 'var_Collf'}
% par2D = height x time x 9
% 
% For arc_slice data go for power profile Ne & height:
% rpar2D: [ppRan,ppAlt,ppNe]
% rpar2D = height x time x 3

tt=Time(1,:); % 1 for start of the data dump, 2 for end of the data dump

% % Power profile electron density data for arc_slice experiment:
% h=rpar2D(:,1,2);
% nelec=rpar2D(:,:,3);

% Electron density data for other experiments:
h=par2D(:,1,2);
nelec=par2D(:,:,3);


i=find(h<=400);

figure(1)
imagesc(tt,h(i),nelec(i,:))
colormap jet;
caxis([1e9 1e11]) %1e10])
axis xy;
dateFormat=15; % 6 = mm/dd, 7 = dd, 5 = mm, 15 = hh:mm, 0 = dd-mmm-yyyy hh:mm:ss 
datetick('x',dateFormat)
colorbar;
xlabel('Time (UT hh:mm)')
ylabel('Height (km)')

