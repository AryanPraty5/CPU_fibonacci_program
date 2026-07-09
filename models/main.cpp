#include<iostream>
#include<fstream>
#include<string>
#include<vector>

using namespace std;

int main(int argc, char *argv[])
{
	string Text;
	vector<string> i_instructions;
	vector<string> o_instructions;

	ifstream ReadFile(argv[1]);
	ofstream WriteFile("o_instructions.txt");

	int i;

	while(getline(ReadFile,Text)){
		i_instructions.push_back(Text);
	}

	int label_pos;

	for(i = 0; i < i_instructions.size(); i++){
		if(i_instructions.at(i) == "LOOP:"){
			label_pos = i;
			i_instructions.erase(i_instructions.begin()+i);
		}
			
	}


	for(i = 0; i < i_instructions.size(); i++){
	
		int pos = (i_instructions.at(i)).find(" ");

		string i_operation;
		string i_address;
		string o_operation;
		string o_address = "";

		i_operation = (i_instructions.at(i)).substr(0,pos);
		i_address = (i_instructions.at(i)).substr(pos+1);
			
			
			if(i_operation == "LOADA")
				o_operation = "000";
			else if(i_operation == "STORE")
				o_operation = "001";
			else if(i_operation == "ADD")
				o_operation = "010";
			else if(i_operation == "SUB")
				o_operation = "011";
			else if(i_operation == "LOADB")
			        o_operation = "100";
			else if(i_operation == "JUMP") 
				o_operation = "101";
			else if(i_operation == "OUT")
				o_operation = "110";
			else if(i_operation == "HALT")
				o_operation = "111";
			else
			      	o_operation = "111";

		if(i_address == "LOOP"){
			int buff[5];
                	int addr_val = label_pos;

               	 	for(int j = 4; j>=0; j--){
                        	buff[j] = ((addr_val >> j) & 1);
                	}

                	for(int k =4; k >=0; k--){
                        	o_address += to_string(buff[k]);
                	}
			string temp = o_operation + o_address;
                	o_instructions.push_back(temp);
		}
		else{
			int buff[5];
			int addr_val = stoi(i_address);

			for(int j = 4; j>=0; j--){
				buff[j] = ((addr_val >> j) & 1);
			}

			for(int k =4; k >=0; k--){
				o_address += to_string(buff[k]);
		}

		string temp = o_operation + o_address;
		o_instructions.push_back(temp);

		}
	}
	
		for(int a = 0; a < o_instructions.size() ; a++){
			WriteFile << o_instructions.at(a) << endl;
		}

	WriteFile.close();	
	ReadFile.close();
	return 0;
}

