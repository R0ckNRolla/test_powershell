// loadLibrary.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "windows.h"
#include <iostream>
using namespace std;

void _tmain(int argc, _TCHAR* argv[]) 
{
  HMODULE mod = LoadLibrary(_T("loadDll32"));
  if (!mod){
    int error = GetLastError();
    if (error!=0){
      cout << "error: " <<error;
      cout << "\n";
    }
  }

  mod = LoadLibrary(_T("loadDll64"));
  //mod = LoadLibrary(_T("SVC_MORE_WELLHIST_RC_RU64"));

  int error = GetLastError();
  if (error!=0){
    cout << "\n";
    cout << "error: " <<error;
  }
  
  for (;;){
		Sleep(10000);
  }
}
