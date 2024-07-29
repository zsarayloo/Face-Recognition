function [r]=active_fun(a,s)
r=exp(-(norm(abs(a)).^2)./(s.^2));