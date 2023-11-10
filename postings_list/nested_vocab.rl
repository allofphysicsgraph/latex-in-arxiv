#include <stdio.h>

%%{
 machine strings;

begin_abstract ='\\begin{abstract}' %{printf(" ");};
end_abstract = '\\end{abstract}' %{printf(" "); };
abstract_body = any+ - (begin_abstract|end_abstract) ;


nested_abstract = begin_abstract:> abstract_body :> end_abstract;
abstract = begin_abstract   abstract_body   end_abstract;

word =  abstract ;
}%%
