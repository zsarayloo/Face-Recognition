%main code for neural network
clc
close all
clear all

%% Generate and preprocess input data
a=40;

I=imread('1.pgm');
Vector_1=Generat_in_vector(I);

I=imread('2.pgm');
Vector_2=Generat_in_vector(I);

I=imread('3.pgm');
Vector_3=Generat_in_vector(I);

I=imread('4.pgm');
Vector_4=Generat_in_vector(I);

I=imread('5.pgm');
Vector_5=Generat_in_vector(I);

I=imread('6.pgm');
Vector_6=Generat_in_vector(I);

I=imread('7.pgm');
Vector_7=Generat_in_vector(I);

I=imread('8.pgm');
Vector_8=Generat_in_vector(I);

I=imread('9.pgm');
Vector_9=Generat_in_vector(I);

I=imread('10.pgm');
Vector_10=Generat_in_vector(I);
%% Cell2

data=[Vector_1;Vector_2;Vector_3;Vector_4;Vector_5;Vector_6;Vector_7;Vector_8;Vector_9;Vector_10];

%% Cell3
data=Generate_in_data(a,data);
data40=data';




