/*
 * InsultGenerator.cpp
 *
 *      written by: Curtis Tremblay
 *      CISC320 assignment 1. A Shakespearean insult generator.
 */

#include "insultgenerator_0cpt.h"
#include <iostream>
#include <fstream>
#include <stdlib.h>
#include <time.h>
#include <vector>
#include <algorithm>
#include <string>

using namespace std;
FileException::FileException(const string& m) : message(m) {}
NumInsultsOutOfBounds::NumInsultsOutOfBounds(const string& m) : message(m) {}
string& FileException::what() { return message; }
string& NumInsultsOutOfBounds::what() { return message; }

void InsultGenerator::initialize(){
    srand (time(NULL));  //Seed the random number generator
    ifstream infile("InsultsSource.txt");
    if(infile.fail()){
        throw FileException("Error: File cannot be read");
    }else{
        string line;
        int i=0;
        while (infile>>first[i]>>second[i]>>third[i]){
            i++;
        }
        infile.close();
        }
}

string InsultGenerator::talkToMe(){
    int v1,v2,v3;
    string insult;
    v1 = rand() % 50;
    v2 = rand() % 50;
    v3 = rand() % 50;
    insult = "Thou " + first[v1] + " " + second[v2] + " " + third[v3] +"!";
    return insult;
}

vector<string> InsultGenerator::generate(int num){
    vector<string> insults;
    string currentinsult;
    if(num<=0){
        throw NumInsultsOutOfBounds("Error: Too few insults");
    }
    else if (num>10000){
        throw NumInsultsOutOfBounds("Error: Too many insults.");
    }
    for (int n=0;n<num; n++){
        currentinsult=talkToMe();
        if(find(insults.begin(), insults.end(), currentinsult) != insults.end()) {
            n--;    //insult is a repeat, decriment counter
        }
        else{
            insults.push_back(currentinsult);
        }
    }
    return insults;
}

void InsultGenerator::generateAndSave(string out_name,int num){
    vector<string> insults;
    insults=generate(num);
    sort(insults.begin(),insults.end());
    ofstream outfile(out_name.c_str());
    if(outfile.fail()){
        throw FileException("Error: File cannot be read");
    }else{
        for (int i = 0; i < num; i++){
            outfile << insults[i]<<endl;
        }
        outfile.close();
    }
}
