%option noyywrap yylineno

%{
#include "scanner.h"
%}

%x COMMENT

ID          [a-zA-Z_]
INT         [0-9]+
FLOAT       ({INT}\.[0-9]*([eE][+-]?{INT})?|{INT}[eE][+-]?{INT})
WS          [ \t\r\n]+

%%

"@"                     { BEGIN(COMMENT); }
<COMMENT>"@"            { BEGIN(INITIAL); }
<COMMENT>\n             { /* yylineno se actualiza automáticamente */ }
<COMMENT>.              { /* descartar contenido de comentario */ }
<COMMENT><<EOF>>        { return TOK_ERROR; }

{WS}                    { /* ignorar espacios */ }

"I"                     { return TOK_KW_INT; }
"F"                     { return TOK_KW_FLOAT; }
"D"                     { return TOK_KW_DOUBLE; }
"C"                     { return TOK_KW_CHAR; }
"V"                     { return TOK_KW_VOID; }
"i"                     { return TOK_KW_IF; }
"e"                     { return TOK_KW_ELSE; }
"w"                     { return TOK_KW_WHILE; }
"f"                     { return TOK_KW_FOR; }
"r"                     { return TOK_KW_RETURN; }
"b"                     { return TOK_KW_BREAK; }
"c"                     { return TOK_KW_CONTINUE; }

"&"                     { return TOK_AND; }
"|"                     { return TOK_OR; }

":"                     { return TOK_ASSIGN; }
"="                     { return TOK_EQ; }
"<"                     { return TOK_LT; }
">"                     { return TOK_GT; }
"!"                     { return TOK_NOT; }
"+"                     { return TOK_PLUS; }
"-"                     { return TOK_MINUS; }
"*"                     { return TOK_MUL; }
"/"                     { return TOK_DIV; }
"%"                     { return TOK_MOD; }

"("                     { return TOK_LPAREN; }
")"                     { return TOK_RPAREN; }
"{"                     { return TOK_LBRACE; }
"}"                     { return TOK_RBRACE; }
"["                     { return TOK_LBRACKET; }
"]"                     { return TOK_RBRACKET; }
","                     { return TOK_COMMA; }
";"                     { return TOK_SEMICOLON; }

{FLOAT}                 { return TOK_FLOAT_LITERAL; }
{INT}                   { return TOK_INT_LITERAL; }
\'([^\\\n]|\\.)\'      { return TOK_CHAR_LITERAL; }
\"([^\\\n]|\\.)*\"     { return TOK_STRING_LITERAL; }
"#"{ID}                 { return TOK_IDENTIFIER; }

<<EOF>>                 { return TOK_EOF; }

.                       { return TOK_ERROR; }

%%
