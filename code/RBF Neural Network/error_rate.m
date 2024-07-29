function [E]=error_rate(error,sample)

if error==0
    error=penalty;   
end
E=(error./sample).*100;
