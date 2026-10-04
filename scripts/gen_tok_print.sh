#!/usr/bin/env bash

mapfile -t tokens < <(grep '^#define.*$' y.tab.h  | grep -v '^#define _yy.*' | awk -F' ' '{ print $2}')

echo -ne "void tok_print(int tok) {
\tswitch(tok) {\n"
for token in "${tokens[@]}"; do
	echo -ne "\t\tcase $token:{ printf(\"%s is a $token\\\n\", yytext); break; }\n"
done
echo -ne "\t}\n}\n"
