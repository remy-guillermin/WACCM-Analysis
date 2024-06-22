function [M, D] = DayNum2Month_Day(Year, DayNum)
    mDays = eomday(Year, 1:12);
    cDays = [0 cumsum(mDays)];
    
    i = find(cDays>=DayNum);
    mi = i(1);
    M = mi-1;
    
    D = DayNum - cDays(mi-1);
end