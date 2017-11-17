%{
int yylex(void);
void yyerror(char *s);
int yywrap(void){
	return 1;
}
#include <stdio.h>
#include<stdlib.h>
enum treetype {operator_node, number_node, variable_node};
typedef struct tree {
  enum treetype nodetype;
   union {
     struct {struct tree *left, *right; char operator;} an_operator;
     int a_number;
     char a_variable;
   } body;
} tree;
static tree *make_operator (tree *l, char o, tree *r) {
   tree *result= (tree*) malloc (sizeof(tree));
   result->nodetype= operator_node;
   result->body.an_operator.left= l;
   result->body.an_operator.operator= o;
   result->body.an_operator.right= r;
   return result;
}

 static tree *make_number (int n) {
   tree *result= (tree*) malloc (sizeof(tree));
   result->nodetype= number_node;
   result->body.a_number= n;
   return result;
}
 static tree *make_variable (char v) {
   tree *result= (tree*) malloc (sizeof(tree));
   result->nodetype= variable_node;
   result->body.a_variable= v;
   return result;
 }
 static void printtree (tree *t, int level) {
 #define step 4
   if (t)
     switch (t->nodetype)
     {
       case operator_node:
        printtree (t->body.an_operator.right, level+step);
        printf ("%*c%c\n", level, ' ', t->body.an_operator.operator);
        printtree (t->body.an_operator.left, level+step);
        break;
       case number_node:
        printf ("%*c%d\n", level, ' ', t->body.a_number);
        break;
       case variable_node:
        printf ("%*c%c\n", level, ' ', t->body.a_variable);
     }
 }
 static void inorder_printtree (tree *t, int level) {
 #define step 4
   if (t)
     switch (t->nodetype)
     {
       case operator_node:
        printtree (t->body.an_operator.left, level+step);
        printf ("%*c%c\n", level, ' ', t->body.an_operator.operator);
        printtree (t->body.an_operator.right, level+step);
        break;
       case number_node:
        printf ("%*c%d\n", level, ' ', t->body.a_number);
        break;
       case variable_node:
        printf ("%*c%c\n", level, ' ', t->body.a_variable);
     }
 }
 static void postorder_printtree (tree *t, int level) {
 #define step 4
   if (t)
     switch (t->nodetype)
     {
       case operator_node:
        printtree (t->body.an_operator.left, level+step);
        printtree (t->body.an_operator.right, level+step);
        printf ("%*c%c\n", level, ' ', t->body.an_operator.operator);
        break;
       case number_node:
        printf ("%*c%d\n", level, ' ', t->body.a_number);
        break;
       case variable_node:
        printf ("%*c%c\n", level, ' ', t->body.a_variable);
     }
 }
%}
%union{
   int a_number;
   char a_variable;
   struct tree *a_tree;
};
%left '+' 
%left '-'
%left '*'
%token <a_number> number
%token <a_variable> variable
%type <a_tree> stmt exp term 

%%
stmt:	variable '=' exp        {$$ = make_operator(make_variable($1),'=',$3);printf("printtree function\n");printtree ($$,1);printf("inorder printttree\n");inorder_printtree($$,1);printf("post-order printttree\n");postorder_printtree($$,1);}
        ;
        
exp:	exp '*' term		{$$ = make_operator($1,'*',$3);}
	|exp '+' term          	{$$ = make_operator ($1, '+', $3);}
        | exp '-' term          {$$ = make_operator ($1, '-', $3);} 
        |term                  	{$$ = $1;}
        ;
        
term:	'(' exp ')'           	{$$ = $2;}	 
	|variable              {$$ = make_variable ($1);}
        ;
%%
void yyerror (char *s) {
	fprintf (stderr, "%s\n", s);
	}
int main (void) {
	return yyparse();
	}
