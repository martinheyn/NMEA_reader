[FileName_NMEA,PathName_NMEA,~] = uigetfile({'*.*';'*.*'},'Select the NMEA file');

[NMEAGPS,NMEACOURSE] = nmeareadgps(FileName_NMEA,PathName_NMEA);
