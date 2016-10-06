%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This function equalises a NMEA dataset                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%
% Input data:
%   NMEA timestamp and NMEA dataset
% 
% Output data:
%   Equalised NMEA dataset and timestamp
%
%    Copyright:     NTNU
%    Project:	    SAMCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2015-01-28  Hans-Martin Heyn (NTNU)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [timevecinterp,equadata] = tool_equalizeNMEA(NMEAtime,NMEAdata)

if length(NMEAtime)~=length(NMEAdata)
    error('Guru meditation: Data and time vector are not of equal length')
end


elapsedtime = etime(datevec(NMEAtime(1,end)),datevec(NMEAtime(1,1)));
timevecinterp = [0:1:elapsedtime];
timevectrue(1) = 0;
datavec(1) = NMEAdata(1);
k = 2;
n = 2;

while (n <= length(NMEAtime))

    temp = etime(datevec(NMEAtime(n)),datevec(NMEAtime(1)));
    if temp > timevectrue(k-1)
        timevectrue(k) = etime(datevec(NMEAtime(n)),datevec(NMEAtime(1)));
        datavec(k) = NMEAdata(n);
        k = k+1;
    end
    n = n+1;
end


equadata = interp1(timevectrue,datavec,timevecinterp);


end