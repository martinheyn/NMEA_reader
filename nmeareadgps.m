%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This function reads the GPS position and time out of the NMEA stream  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nmeareadgps: Reads the GPS messages in the NMEA string of OATRC 2015
%
% Input data:
%   Logged NMEA stream
% 
% Output data:
%   Struct with Datenum, Lat, Lon, Number of sats, HDOP, Altitude 
%   Struct with Datenum, Speed in knots, Speed in kph, Magnetic Course,
%   True Course
%
%    Copyright:     NTNU
%    Project:	    SAMCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2015-01-18  Hans-Martin Heyn (NTNU)
%    Date modified: 2015-01-19  Hans-Martin Heyn (NTNU) [Added course
%    reading)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function [GPSdata,COURSEdata] = nmeareadgps(FileNameNMEA,PathNameNMEA)
%NMEAREADGPS Summary of this function goes here

filepath = strcat(PathNameNMEA,'/',FileNameNMEA);

fid = fopen(filepath);
tline = fgetl(fid);
m = 1;
n = 1;
erro = 0;
GPStime = 0;

% Getting the date, which is only saved in the filename (AND NOT IN THE GPS
% SIGNAL!!!!!!!
NMEAdate = strcat(FileNameNMEA(5:6),'/',FileNameNMEA(7:8),'/',FileNameNMEA(1:4));
NMEAdate = datenum(NMEAdate);
fprintf(strcat('It was the ',datestr(NMEAdate),'\n'))
% End of date finding

while ischar(tline)
    try
        [NMEAdata,ierr] = nmealineread(tline);
    catch
        %warning('Yeah that did not work out that well')
        ierr = 99;
        erro = erro + 1;
    end
    if (ierr == 0) % NMEA string recognised
        lengthNMEA = length(fieldnames(NMEAdata));
            if (GPStime~=0)
            
               switch lengthNMEA
                 case 7
                GPStime = NMEAdate + NMEAdata.BODCTime;
                GPSdata(1,m) = GPStime;
                GPSdata(2,m) = NMEAdata.HDOP;
                GPSdata(3,m) = NMEAdata.altitude;
                GPSdata(4,m) = NMEAdata.fix;
                GPSdata(5,m) = NMEAdata.latitude;
                GPSdata(6,m) = NMEAdata.longitude;
                GPSdata(7,m) = NMEAdata.satellites;
                m = m + 1;
                
                case 4
                COURSEdata(1,n) = GPStime;
                COURSEdata(2,n) = NMEAdata.groundspeedknot;
                COURSEdata(3,n) = NMEAdata.groundspeedkph;
                COURSEdata(4,n) = NMEAdata.magneticcourse;
                COURSEdata(5,n) = NMEAdata.truecourse;
                n = n + 1;
               end
            else
                if (lengthNMEA == 7)
                GPStime = NMEAdate + NMEAdata.BODCTime;
                GPSdata(1,m) = GPStime;
                GPSdata(2,m) = NMEAdata.HDOP;
                GPSdata(3,m) = NMEAdata.altitude;
                GPSdata(4,m) = NMEAdata.fix;
                GPSdata(5,m) = NMEAdata.latitude;
                GPSdata(6,m) = NMEAdata.longitude;
                GPSdata(7,m) = NMEAdata.satellites;
                m = m + 1;
                end
                
                
            end
    end
    tline = fgetl(fid);
      
end

fclose(fid);
fprintf(strcat('I wrote =>',num2str(m),'<= lines with GPS data','\n','I wrote =>',num2str(n),'<= lines of course data','\n','I could not read =>',num2str(erro),'<= entries','\n','Signing off, have a good day','\n'));    
  


end

