/*
*   CISC 320 Assignment 1
*   Written By: Curtis Tremblay
*   Created using CodeBlocks and MinGW on Windows
*/
#pragma once

#include <string>
#include <vector>
using namespace std;

class FileException {
public:
	FileException(const string&);   //determines the error message
	string& what(); //returns what the error is
private:
	string message; //the message to be returned to the error stream
};

class NumInsultsOutOfBounds {
public:
	NumInsultsOutOfBounds(const string&);   //determines the error message
	string& what(); //returns what the error is
private:
	string message; //the message to be returned to the error stream
};


class InsultGenerator
{
    public:
        void initialize();  //Initialize the insult generator
        string talkToMe();  //Returns a single insult
        vector<string> generate(int num);   //Returns a vector of insults
        void generateAndSave(string out_name,int num); //generates a vector of insults and saves to a text file
    private:
        string first[50], second[50],third[50]; //arrays for storing words from text file
};

