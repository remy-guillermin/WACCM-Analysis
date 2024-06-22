% Extracting variables from a single sat-file:
% Each variable is 10009 points (time) & chemical components have height
% information for 88 pressure surfaces (lev)
% Variable names are...

fname='SatFiles2000/SPE/unis_ref_spe2.cam2.sat-grnd-v3.2000-07-28-79200.nc';
lat=ncread(fname,'instr_lat');
lon=ncread(fname,'instr_lon');
num=ncread(fname,'instr_num');
date=ncread(fname,'obs_date'); % YYYYMMDD
time=ncread(fname,'obs_time'); % s
lev=ncread(fname,'lev'); % 88 levels
Ne=ncread(fname,'e'); % mol/mol, mixing ratio
T=ncread(fname,'T');


% Tromsø: 69.66	18.94 -- closest point 69.6, 19.2; instr_num = 125
% Ny-Ålesund: 78.92	11.95 -- closest point 78.925, 11.922; instr_num = 128

% This should be finding for an instrument number...
i=find(lat > 69.5 & lat < 69.7); % 354 points, all with lon=19.2
% Ne(:,i) % to select time stamps for profiles...

% Pressure levels can be converted to height with an equation:
% z=-Hln(pz/p0), where a decent assumption of the scale height H is 7km (p0 = standard sea level pressure)
%
% Roughly the conversion should give these heights
% 10-5hPa ~ 110km, 10-4hPa ~ 100km, 10-3hPa ~ 90km, 10-2hPa ~ 80km, 10-1hPa ~ 65km, 10e0hPa ~ 50km, 10e1hPa ~ 35-40km


% Concentration = mixing ratio * concentration of air 
%               = mixing ratio * pressure / k * temperature, k=1.38*10^-23 J/K
%               = e * lev / k * T 
%
% Electron density profile for the 1st time stamp is then:
figure(1)
j=find(lev < 0.1);
plot(Ne(j,1).*lev(j)./1.38e-23./T(j,1)*1e3,lev(j)) % m-3
set(gca, 'YScale', 'log','ydir','reverse')
grid on;
ylabel('Pressure (hPa)')
xlabel('Electron density (m-3)')



% Test period: 2000-07-28 -- 2000-08-05
% Time stamps have a half-hour resolution, but seconds must be converted from integer to float...
hours=double(time(i))/3600;

% % This gives individual time stamps for each point with Tromsø coordinates
% % 2000-7-27 22:00:00 --- 2000-7-28 04:00:00 in half-hour steps, each 20-30
% % times....
% % For model date... not obs_date!
% tt=[];
% for ii=1:length(i)
%     [month,day]=doy2date(2000,time(ii));
%     tt=[tt; datenum(2000,month,day); ]; % datevec(tt) then gives a full human understandable time stamp
% end;



