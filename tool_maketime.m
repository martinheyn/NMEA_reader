%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This script creates a common time vector for IMU, GPS and Heading data%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tool_maketime
%
% Input data:
%   GPS, COMPASS and IMU data must be in workspace
% 
% Output data:
%   Three time-vectors in MATLAB time
%
%    Copyright:     NTNU
%    Project:	    SAMCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2015-01-27  Hans-Martin Heyn (NTNU)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

imutimevec = imu_1_data_si(14:19,:);
IMUtimenum = datenum(imutimevec');

IMUreltime = imu_1_data_si(1,:);
GPStimenum = NMEAGPS(1,:);

COURSEtimenum = NMEACOURSE(1,:);

clear imutimevec