function [meaner, stdever] = meanSTDCalc(structureName, starter ,ender )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
meanArray = [];
for ii = starter:ender
    meanArray = [meanArray structureName(ii)];
end

meaner = mean(meanArray, 2);
stdever = std(meanArray, 2);
end

